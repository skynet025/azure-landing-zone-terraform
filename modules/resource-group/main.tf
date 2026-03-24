# -------------------------------------------------------------------
# Resource Group module
# -------------------------------------------------------------------
# Ce module encapsule la création d'un Resource Group Azure.
# -------------------------------------------------------------------

resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
  tags     = var.tags
}