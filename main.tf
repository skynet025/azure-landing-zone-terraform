# -------------------------------------------------------------------
# Resource Group module call
# -------------------------------------------------------------------
# Le root module délègue la création du Resource Group
# à un module réutilisable.
# -------------------------------------------------------------------

module "resource_group" {
  source = "./modules/resource-group"

  name     = local.naming.rg
  location = var.location
  tags     = local.common_tags
}

# -------------------------------------------------------------------
# Hub network module call
# -------------------------------------------------------------------
# Ce module crée un VNet hub simple qui servira de réseau partagé.
# -------------------------------------------------------------------

module "hub_network" {
  source = "./modules/network"

  vnet_name           = "vnet-${var.org}-hub-shared-${var.env}-${var.region_code}-${var.instance}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  address_space       = ["10.100.0.0/16"]

  subnet_name     = "snet-shared"
  subnet_prefixes = ["10.100.1.0/24"]

  tags = local.common_tags
}

# -------------------------------------------------------------------
# Spoke Network module call
# -------------------------------------------------------------------
# Le root module délègue la création du VNet et du subnet app
# à un module réseau réutilisable.
# -------------------------------------------------------------------

module "network" {
  source = "./modules/network"

  vnet_name           = local.naming.vnet
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  address_space       = ["10.200.0.0/16"]

  subnet_name     = "snet-app"
  subnet_prefixes = ["10.200.1.0/24"]

  tags = local.common_tags
}

# -------------------------------------------------------------------
# Peering from spoke to hub
# -------------------------------------------------------------------
# Permet au spoke de communiquer avec le hub.
# -------------------------------------------------------------------

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = local.naming.peer_spoke_to_hub
  resource_group_name       = module.resource_group.name
  virtual_network_name      = module.network.vnet_name
  remote_virtual_network_id = module.hub_network.vnet_id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# -------------------------------------------------------------------
# Peering from hub to spoke
# -------------------------------------------------------------------
# Le peering Azure doit être créé dans les deux sens.
# -------------------------------------------------------------------

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = local.naming.peer_hub_to_spoke
  resource_group_name       = module.resource_group.name
  virtual_network_name      = module.hub_network.vnet_name
  remote_virtual_network_id = module.network.vnet_id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# -------------------------------------------------------------------
# Security module
# -------------------------------------------------------------------
# Le root module délègue la création du NSG, de la règle RDP
# et de l'association du NSG au subnet applicatif.
# -------------------------------------------------------------------

module "security" {
  source = "./modules/security"

  nsg_name            = local.naming.nsg
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  # On consomme l'output du module network
  subnet_id      = module.network.subnet_id
  allowed_rdp_ip = var.admin_public_ip

  tags = local.common_tags
}

# -------------------------------------------------------------------
# Compute module
# -------------------------------------------------------------------

module "compute" {
  source = "./modules/compute"

  vm_name             = local.naming.vm
  computer_name       = local.naming.vm_computer_name
  nic_name            = local.naming.nic
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.network.subnet_id

  vm_size        = "Standard_D2als_v6"
  admin_username = "azureadmin"
  admin_password = random_password.vm_admin.result

  tags = local.common_tags
}

# -------------------------------------------------------------------
# Random password for Windows VM local administrator
# -------------------------------------------------------------------
# Ce mot de passe est généré automatiquement par Terraform.
# Il sera ensuite stocké dans Key Vault.
# Attention : même marqué "sensitive", il peut toujours apparaître
# dans le state Terraform car il est utilisé par la VM.
# -------------------------------------------------------------------

resource "random_password" "vm_admin" {
  length           = 20
  special          = true
  override_special = "!@#$%&*()-_=+[]{}<>:?"
}

# -------------------------------------------------------------------
# Key Vault module
# -------------------------------------------------------------------
# Le root module délègue la création du Key Vault,
# les assignations RBAC explicites et le stockage du secret.
# Les identités autorisées sont déclarées explicitement afin
# de ne pas dépendre du caller Terraform.
# -------------------------------------------------------------------

module "keyvault" {
  source = "./modules/keyvault"

  key_vault_name      = local.naming.kv
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tenant_id           = var.tenant_id

  # Liste explicite des identités autorisées sur le Key Vault
  keyvault_access_principal_ids = [
    var.github_sp_object_id,
    var.local_user_object_id
  ]

  # Secret stocké dans le Key Vault
  secret_name  = "vm-admin-password"
  secret_value = random_password.vm_admin.result

  tags = local.common_tags
}
# -------------------------------------------------------------------
# Storage private module
# -------------------------------------------------------------------
# Déploie un Storage Account privé dans le spoke avec :
# - Private Endpoint
# - Private DNS Zone
# - DNS VNet Link
# -------------------------------------------------------------------

module "storage_private" {
  source = "./modules/storage-private"

  storage_account_name  = local.naming.st
  private_endpoint_name = local.naming.pe_blob
  dns_vnet_link_name    = local.naming.dnslink_blob

  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  # Private Endpoint dans le subnet spoke existant
  subnet_id = module.network.subnet_id

  # Zone DNS privée liée au spoke
  virtual_network_id = module.network.vnet_id

  tags = local.common_tags
}
# -------------------------------------------------------------------
# Routing module
# -------------------------------------------------------------------
# Crée une route table spoke avec une route de préparation
# vers un futur transit hub.
# On ne l'associe pas encore au subnet applicatif.
# -------------------------------------------------------------------

module "routing" {
  source = "./modules/routing"

  route_table_name    = local.naming.rt_spoke
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  route_name             = local.naming.route_default_to_hub
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.100.1.4"

  tags = local.common_tags
}

# -------------------------------------------------------------------
# Test subnet in spoke VNet
# -------------------------------------------------------------------
# Ce subnet sert à tester l'association d'une route table sans
# impacter le subnet applicatif existant.
# -------------------------------------------------------------------

resource "azurerm_subnet" "test" {
  name                 = local.naming.snet_test
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.network.vnet_name
  address_prefixes     = ["10.200.2.0/24"]
}

# -------------------------------------------------------------------
# Route table association for test subnet
# -------------------------------------------------------------------
# On associe la route table au subnet de test uniquement.
# On ne touche pas au subnet applicatif tant qu'aucune appliance
# réelle n'existe dans le hub.
# -------------------------------------------------------------------

resource "azurerm_subnet_route_table_association" "test" {
  subnet_id      = azurerm_subnet.test.id
  route_table_id = module.routing.route_table_id
}
# -------------------------------------------------------------------
# Test NIC in test subnet
# -------------------------------------------------------------------
# Cette NIC sert uniquement à lire les effective routes sur le subnet
# de test associé à la route table spoke.
# -------------------------------------------------------------------

resource "azurerm_network_interface" "test" {
  name                = local.naming.nic_test
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = local.common_tags
}

# -------------------------------------------------------------------
# VM de test pour validation routing
# -------------------------------------------------------------------
resource "azurerm_windows_virtual_machine" "test" {
  name                = "vm-${var.org}-${var.workload}-test-${var.env}-${var.region_code}-${var.instance}"
  computer_name       = local.naming.vm_test_computer_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  size                = "Standard_B2s"

  admin_username = "azureuser"
  admin_password = random_password.vm_admin.result

  network_interface_ids = [
    azurerm_network_interface.test.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "osdisk-test"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
}