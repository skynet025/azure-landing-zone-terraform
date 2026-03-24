# -------------------------------------------------------------------
# Variables du module compute
# -------------------------------------------------------------------
# Ce module crée une VM Windows avec sa NIC associée.
# -------------------------------------------------------------------

variable "vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
}

variable "computer_name" {
  description = "Windows computer name (<=15 chars)"
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

variable "subnet_id" {
  description = "Subnet ID where NIC will be attached"
  type        = string
}

variable "vm_size" {
  description = "VM size"
  type        = string
}

variable "admin_username" {
  description = "Admin username"
  type        = string
}

variable "admin_password" {
  description = "Admin password"
  type        = string
  sensitive   = true
}

# -------------------------------------------------------------------
# Nom de la NIC
# -------------------------------------------------------------------
# Permet de garder une naming convention cohérente côté root module.
# -------------------------------------------------------------------

variable "nic_name" {
  description = "Name of the Network Interface"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
}