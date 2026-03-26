variable "subscription_id" {
  description = "Azure subscription ID target"
  type        = string
}

variable "org" {
  description = "Organization code"
  type        = string
}

variable "workload" {
  description = "Workload or domain name"
  type        = string
}

variable "scope" {
  description = "Scope or resource purpose"
  type        = string
}

variable "env" {
  description = "Environment code"
  type        = string

  validation {
    condition     = contains(["np", "prd"], var.env)
    error_message = "env must be either 'np' or 'prd'."
  }
}

variable "region_code" {
  description = "Short region code"
  type        = string
}

variable "instance" {
  description = "Instance number"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "owner" {
  description = "Owner tag"
  type        = string
}

variable "costcenter" {
  description = "Cost center tag"
  type        = string
}

variable "data_classification" {
  description = "Data classification tag"
  type        = string
}

# IP publique autorisée pour l'accès RDP d'administration
variable "admin_public_ip" {
  description = "Public IP allowed to access RDP on the demo subnet"
  type        = string
}

# -------------------------------------------------------------------
# Nom administrateur VM
# -------------------------------------------------------------------
variable "vm_admin_username" {
  description = "Administrator username for the VM"
  type        = string
}

# -------------------------------------------------------------------
# Azure tenant ID
# -------------------------------------------------------------------
# Nécessaire pour créer le Key Vault
# -------------------------------------------------------------------
variable "tenant_id" {
  description = "Azure tenant ID used by Key Vault"
  type        = string
}

# -------------------------------------------------------------------
# Key Vault access principals
# -------------------------------------------------------------------
# Object IDs explicitement autorisés à gérer les secrets du Key Vault.
# -------------------------------------------------------------------

variable "github_sp_object_id" {
  description = "Object ID of the GitHub Actions Service Principal"
  type        = string
}

variable "local_user_object_id" {
  description = "Object ID of the local Azure user allowed to manage Key Vault secrets"
  type        = string
}