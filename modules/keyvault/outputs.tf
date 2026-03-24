# -------------------------------------------------------------------
# Outputs du module keyvault
# -------------------------------------------------------------------

output "key_vault_id" {
  description = "Key Vault resource ID"
  value       = azurerm_key_vault.this.id
}

output "key_vault_name" {
  description = "Key Vault name"
  value       = azurerm_key_vault.this.name
}

output "secret_id" {
  description = "Key Vault secret ID"
  value       = azurerm_key_vault_secret.this.id
}