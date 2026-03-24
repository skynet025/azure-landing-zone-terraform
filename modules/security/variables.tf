# -------------------------------------------------------------------
# Variables du module security
# -------------------------------------------------------------------

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  description = "Subnet ID to associate NSG with"
  type        = string
}

variable "allowed_rdp_ip" {
  description = "IP allowed to access RDP"
  type        = string
}

variable "tags" {
  type = map(string)
}