# -------------------------------------------------------------------
# Variables du module storage-private
# -------------------------------------------------------------------
# Ce module crée un Storage Account privé avec :
# - Private Endpoint
# - Private DNS Zone
# - VNet Link
# - DNS Zone Group
# -------------------------------------------------------------------

variable "storage_account_name" {
  description = "Storage Account name"
  type        = string
}

variable "private_endpoint_name" {
  description = "Private Endpoint name"
  type        = string
}

variable "dns_vnet_link_name" {
  description = "Private DNS VNet Link name"
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
  description = "Subnet ID used for the Private Endpoint"
  type        = string
}

variable "virtual_network_id" {
  description = "Virtual Network ID used for the Private DNS Link"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}