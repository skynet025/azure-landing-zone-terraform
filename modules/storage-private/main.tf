# -------------------------------------------------------------------
# Storage Account
# -------------------------------------------------------------------
# Storage Account standard pour le lab.
# On garde l'accès public activé pour l'instant afin de se concentrer
# sur le fonctionnement du Private Endpoint et du DNS privé.
# On pourra durcir ensuite.
# -------------------------------------------------------------------

resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

# -------------------------------------------------------------------
# Private DNS Zone for Blob
# -------------------------------------------------------------------
# Cette zone permet de résoudre le service blob du Storage Account
# vers l'IP privée du Private Endpoint.
# -------------------------------------------------------------------

resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# -------------------------------------------------------------------
# Private DNS Zone VNet Link
# -------------------------------------------------------------------
# Lie la zone DNS privée au VNet du spoke pour permettre la résolution.
# -------------------------------------------------------------------

resource "azurerm_private_dns_zone_virtual_network_link" "blob" {
  name                  = var.dns_vnet_link_name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = var.virtual_network_id

  tags = var.tags
}

# -------------------------------------------------------------------
# Private Endpoint for Blob
# -------------------------------------------------------------------
# Expose le sous-service Blob du Storage Account sur une IP privée
# dans le subnet fourni.
# Le bloc private_dns_zone_group associe le Private Endpoint
# à la zone DNS privée blob.
# -------------------------------------------------------------------

resource "azurerm_private_endpoint" "blob" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.private_endpoint_name}-conn"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  # Association DNS privée directement dans le Private Endpoint
  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.blob.id]
  }

  tags = var.tags
}