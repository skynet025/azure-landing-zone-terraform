# -------------------------------------------------------------------
# Azure Key Vault
# -------------------------------------------------------------------
# Ce coffre Azure stocke les secrets du lab.
# Le modèle RBAC moderne est utilisé.
# -------------------------------------------------------------------

resource "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tenant_id = var.tenant_id
  sku_name  = "standard"

  # Active le modèle RBAC moderne
  rbac_authorization_enabled = true

  # Paramètres minimum pour le lab
  purge_protection_enabled   = false
  soft_delete_retention_days = 7

  tags = var.tags
}

# -------------------------------------------------------------------
# Role assignment for Key Vault Secrets Officer
# -------------------------------------------------------------------
# Donne au principal fourni la capacité de gérer les secrets
# dans le Key Vault.
# -------------------------------------------------------------------

resource "azurerm_role_assignment" "secrets_officer" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = var.principal_id
}

# -------------------------------------------------------------------
# Key Vault secret
# -------------------------------------------------------------------
# Stocke la valeur sensible dans le Key Vault.
# On dépend explicitement du rôle RBAC.
# -------------------------------------------------------------------

resource "azurerm_key_vault_secret" "this" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = azurerm_key_vault.this.id

  depends_on = [azurerm_role_assignment.secrets_officer]
}