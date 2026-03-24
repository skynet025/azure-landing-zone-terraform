# -------------------------------------------------------------------
# Variables du module network
# -------------------------------------------------------------------
# Ce module crée un VNet Azure avec un subnet applicatif.
# -------------------------------------------------------------------

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "location" {
  description = "Azure region for the VNet"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group where the VNet will be created"
  type        = string
}

variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

# -------------------------------------------------------------------
# Generic subnet configuration
# -------------------------------------------------------------------
# Le module network crée un VNet avec un subnet unique fourni
# en entrée. Cela permet de réutiliser le module pour un spoke
# ou un hub simple.
# -------------------------------------------------------------------

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "subnet_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
}

variable "tags" {
  description = "Common tags applied to network resources"
  type        = map(string)
}