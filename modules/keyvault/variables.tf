# -------------------------------------------------------------------
# Variables du module keyvault
# -------------------------------------------------------------------
# Ce module crée un Key Vault Azure, assigne un rôle RBAC
# à un principal, puis stocke un secret.
# -------------------------------------------------------------------

variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "principal_id" {
  description = "Principal ID receiving RBAC on the Key Vault"
  type        = string
}

variable "secret_name" {
  description = "Name of the secret stored in Key Vault"
  type        = string
}

variable "secret_value" {
  description = "Value of the secret stored in Key Vault"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}