terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    # Provider utilisé pour générer des secrets aléatoires
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-jgfs-plat-tfstate-np-frc-01"
    storage_account_name = "stjgfstfstate01"
    container_name       = "tfstate"
    key                  = "terraform-lab.tfstate"
  }
}