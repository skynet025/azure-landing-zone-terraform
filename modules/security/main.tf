# -------------------------------------------------------------------
# Network Security Group
# -------------------------------------------------------------------

resource "azurerm_network_security_group" "this" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# -------------------------------------------------------------------
# NSG Rule - Allow RDP from my IP
# -------------------------------------------------------------------

resource "azurerm_network_security_rule" "allow_rdp_myip" {
  name      = "allow-rdp-myip"
  priority  = 100
  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  source_port_range      = "*"
  destination_port_range = "3389"

  source_address_prefix      = var.allowed_rdp_ip
  destination_address_prefix = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
}

# -------------------------------------------------------------------
# NSG Association with subnet
# -------------------------------------------------------------------

resource "azurerm_subnet_network_security_group_association" "this" {
  # ID du subnet fourni par le root module
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.this.id
}