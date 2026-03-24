# -------------------------------------------------------------------
# Route Table
# -------------------------------------------------------------------
# Cette route table prépare le futur transit hub.
# Elle n'est pas encore associée au subnet applicatif pour ne pas
# perturber le trafic tant qu'aucune appliance réelle n'existe.
# -------------------------------------------------------------------

resource "azurerm_route_table" "this" {
  name                = var.route_table_name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags
}

# -------------------------------------------------------------------
# UDR Route
# -------------------------------------------------------------------
# Route de préparation vers un futur hub de transit.
# -------------------------------------------------------------------

resource "azurerm_route" "this" {
  name                   = var.route_name
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.this.name
  address_prefix         = var.address_prefix
  next_hop_type          = var.next_hop_type
  next_hop_in_ip_address = var.next_hop_in_ip_address
}