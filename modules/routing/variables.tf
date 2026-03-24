# -------------------------------------------------------------------
# Variables du module routing
# -------------------------------------------------------------------
# Ce module crée une route table Azure avec une route UDR
# de préparation vers un futur transit hub.
# -------------------------------------------------------------------

variable "route_table_name" {
  description = "Route table name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "route_name" {
  description = "UDR route name"
  type        = string
}

variable "address_prefix" {
  description = "Destination address prefix"
  type        = string
}

variable "next_hop_type" {
  description = "Next hop type"
  type        = string
}

variable "next_hop_in_ip_address" {
  description = "Next hop IP for VirtualAppliance routes"
  type        = string
  default     = null
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}