# -------------------------------------------------------------------
# Virtual Network
# -------------------------------------------------------------------
# Ce VNet constitue le conteneur réseau principal du workload.
# -------------------------------------------------------------------

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

# -------------------------------------------------------------------
# Subnet
# -------------------------------------------------------------------
# Subnet générique du VNet.
# Le nom et le préfixe sont fournis par le root module.
# -------------------------------------------------------------------

resource "azurerm_subnet" "this" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.subnet_prefixes
}