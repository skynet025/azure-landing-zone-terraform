# -------------------------------------------------------------------
# Variables du module resource-group
# -------------------------------------------------------------------
# Ce module crée un Resource Group Azure standardisé.
# -------------------------------------------------------------------

variable "name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region for the Resource Group"
  type        = string
}

variable "tags" {
  description = "Common tags applied to the Resource Group"
  type        = map(string)
}