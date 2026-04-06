# -------------------------------------------------------------------
# Azure subscription
# -------------------------------------------------------------------
# ID de la souscription cible
# Pourquoi : éviter de lancer un apply sur la mauvaise subscription
# -------------------------------------------------------------------
variable "subscription_id" {
  description = "Azure subscription ID target"
  type        = string

  validation {
    condition     = length(var.subscription_id) > 0
    error_message = "subscription_id must not be empty."
  }
}

# -------------------------------------------------------------------
# Naming context
# -------------------------------------------------------------------
# Variables utilisées pour construire les noms des ressources
# -------------------------------------------------------------------

variable "org" {
  description = "Organization code"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.org))
    error_message = "org must contain only lowercase letters and numbers."
  }
}

variable "workload" {
  description = "Workload or domain name"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.workload))
    error_message = "workload must contain only lowercase letters and numbers."
  }
}

variable "scope" {
  description = "Scope or resource purpose"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.scope))
    error_message = "scope must contain only lowercase letters and numbers."
  }
}

# -------------------------------------------------------------------
# Environment
# -------------------------------------------------------------------
# On limite volontairement aux environnements connus
# Pourquoi : éviter les dérives (dev, test, prod, etc.)
# -------------------------------------------------------------------
variable "env" {
  description = "Environment code"
  type        = string

  validation {
    condition     = contains(["np", "prd"], var.env)
    error_message = "env must be either 'np' or 'prd'."
  }
}

# -------------------------------------------------------------------
# Region
# -------------------------------------------------------------------

variable "region_code" {
  description = "Short region code"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.region_code))
    error_message = "region_code must contain only lowercase letters and numbers."
  }
}

variable "location" {
  description = "Azure region"
  type        = string
  validation {
    condition     = length(var.location) > 0
    error_message = "location must not be empty."
  }

}

# -------------------------------------------------------------------
# Instance
# -------------------------------------------------------------------
# Numéro d’instance (01, 02, etc.)
# Pourquoi : standard entreprise pour multi-déploiements
# -------------------------------------------------------------------
variable "instance" {
  description = "Instance number"
  type        = string

  validation {
    condition     = can(regex("^\\d{2}$", var.instance))
    error_message = "instance must be a 2-digit number (e.g. 01, 02)."
  }
}

# -------------------------------------------------------------------
# Tags
# -------------------------------------------------------------------

variable "owner" {
  description = "Owner tag"
  type        = string

  validation {
    condition     = length(var.owner) > 0
    error_message = "owner must not be empty."
  }
}

variable "costcenter" {
  description = "Cost center tag"
  type        = string

  validation {
    condition     = length(var.costcenter) > 0
    error_message = "costcenter must not be empty."
  }
}

variable "data_classification" {
  description = "Data classification tag"
  type        = string

  validation {
    condition     = contains(["public", "internal", "confidential"], var.data_classification)
    error_message = "data_classification must be public, internal or confidential."
  }
}

# -------------------------------------------------------------------
# Network access
# -------------------------------------------------------------------
# IP autorisée pour RDP
# Pourquoi : éviter une mauvaise config type 0.0.0.0/0
# -------------------------------------------------------------------
variable "admin_public_ip" {
  description = "Public IP allowed to access RDP on the demo subnet"
  type        = string

  validation {
    condition     = can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+/32$", var.admin_public_ip))
    error_message = "admin_public_ip must be a valid /32 IP (e.g. 1.2.3.4/32)."
  }
}

# -------------------------------------------------------------------
# VM admin
# -------------------------------------------------------------------
# Nom admin Windows
# Pourquoi : contraintes OS + bonnes pratiques sécurité
# -------------------------------------------------------------------
variable "vm_admin_username" {
  description = "Administrator username for the VM"
  type        = string

  validation {
    condition     = length(var.vm_admin_username) >= 3 && length(var.vm_admin_username) <= 20
    error_message = "vm_admin_username must be between 3 and 20 characters."
  }
}

# -------------------------------------------------------------------
# Azure tenant
# -------------------------------------------------------------------
variable "tenant_id" {
  description = "Azure tenant ID used by Key Vault"
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.tenant_id))
    error_message = "tenant_id must be a valid GUID."
  }
}

# -------------------------------------------------------------------
# Key Vault principals
# -------------------------------------------------------------------

variable "github_sp_object_id" {
  description = "Object ID of the GitHub Actions Service Principal"
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.github_sp_object_id))
    error_message = "github_sp_object_id must be a valid GUID."
  }
}

variable "local_user_object_id" {
  description = "Object ID of the local Azure user allowed to manage Key Vault secrets"
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.local_user_object_id))
    error_message = "local_user_object_id must be a valid GUID."
  }
}

# -------------------------------------------------------------------
# Secret expiration
# -------------------------------------------------------------------
# Format ISO8601 UTC obligatoire
# Pourquoi : éviter des secrets sans expiration (fail sécurité)
# -------------------------------------------------------------------
variable "secret_expiration_date" {
  description = "Expiration date for Key Vault secrets (RFC3339 format)"
  type        = string

  validation {
    condition     = can(regex("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z$", var.secret_expiration_date))
    error_message = "secret_expiration_date must be in RFC3339 format (e.g. 2027-01-01T00:00:00Z)."
  }
}