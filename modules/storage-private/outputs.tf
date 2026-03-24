# -------------------------------------------------------------------
# Outputs du module storage-private
# -------------------------------------------------------------------

output "storage_account_id" {
  description = "Storage Account ID"
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "Storage Account name"
  value       = azurerm_storage_account.this.name
}

output "private_endpoint_id" {
  description = "Private Endpoint ID"
  value       = azurerm_private_endpoint.blob.id
}

output "private_dns_zone_id" {
  description = "Private DNS Zone ID"
  value       = azurerm_private_dns_zone.blob.id
}