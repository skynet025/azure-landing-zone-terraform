# -------------------------------------------------------------------
# Azure Key Vault
# -------------------------------------------------------------------
# Le Key Vault est configuré en RBAC, avec purge protection activée.
# L'accès réseau public reste temporairement autorisé car le pipeline
# GitHub Actions utilise des runners hébergés publiquement et doit
# pouvoir accéder au data plane du Key Vault.
# -------------------------------------------------------------------
resource "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tenant_id = var.tenant_id
  sku_name  = "standard"

  # -----------------------------------------------------------------
  # Use RBAC authorization model
  # -----------------------------------------------------------------
  rbac_authorization_enabled = true

  # -----------------------------------------------------------------
  # Recovery and protection settings
  # -----------------------------------------------------------------
  # Purge protection est activée pour renforcer la résilience du coffre.
  # -----------------------------------------------------------------
  purge_protection_enabled   = true
  soft_delete_retention_days = 7

  # -----------------------------------------------------------------
  # Network access
  # -----------------------------------------------------------------
  # L'accès public reste activé temporairement pour permettre au
  # pipeline GitHub-hosted d'interagir avec le Key Vault.
  # Une future évolution consistera à basculer vers Private Endpoint
  # + connectivité privée pour désactiver l'accès public.
  # -----------------------------------------------------------------
  public_network_access_enabled = true

  tags = var.tags
}

# -------------------------------------------------------------------
# Role assignments for Key Vault Secrets Officer
# -------------------------------------------------------------------
# Donne à chaque principal explicitement fourni la capacité
# de gérer les secrets dans le Key Vault.
# On évite ainsi de dépendre de l'identité courante qui exécute Terraform.
# -------------------------------------------------------------------

resource "azurerm_role_assignment" "secrets_officer" {
  for_each = toset(var.keyvault_access_principal_ids)

  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = each.value
}

# -------------------------------------------------------------------
# Key Vault secret
# -------------------------------------------------------------------
# Stocke la valeur sensible dans le Key Vault.
# On dépend explicitement des assignations RBAC afin de limiter
# les problèmes de propagation des permissions.
# -------------------------------------------------------------------

resource "azurerm_key_vault_secret" "this" {
  name            = var.secret_name
  value           = var.secret_value
  key_vault_id    = azurerm_key_vault.this.id
  content_type    = "password"
  expiration_date = var.secret_expiration_date

  depends_on = [azurerm_role_assignment.secrets_officer]
}