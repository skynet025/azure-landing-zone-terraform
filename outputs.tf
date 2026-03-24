# -------------------------------------------------------------------
# Root module outputs
# -------------------------------------------------------------------
# Ce fichier expose uniquement les outputs utiles du lab.
# Le root module sert d'interface finale pour l'utilisateur
# ou pour un pipeline CI/CD.
# -------------------------------------------------------------------

# -------------------------------------------------------------------
# Resource Group
# -------------------------------------------------------------------

output "resource_group_name" {
  description = "Resource Group name"
  value       = module.resource_group.name
}

output "resource_group_location" {
  description = "Resource Group location"
  value       = module.resource_group.location
}

output "resource_group_id" {
  description = "Resource Group ID"
  value       = module.resource_group.id
}

# -------------------------------------------------------------------
# Networking
# -------------------------------------------------------------------

output "spoke_vnet_name" {
  description = "Spoke Virtual Network name"
  value       = module.network.vnet_name
}

output "spoke_vnet_id" {
  description = "Spoke Virtual Network ID"
  value       = module.network.vnet_id
}

output "spoke_subnet_name" {
  description = "Spoke application subnet name"
  value       = module.network.subnet_name
}

output "spoke_subnet_id" {
  description = "Spoke application subnet ID"
  value       = module.network.subnet_id
}

output "hub_vnet_name" {
  description = "Hub Virtual Network name"
  value       = module.hub_network.vnet_name
}

output "hub_vnet_id" {
  description = "Hub Virtual Network ID"
  value       = module.hub_network.vnet_id
}

# -------------------------------------------------------------------
# Compute
# -------------------------------------------------------------------

output "vm_name" {
  description = "Virtual Machine name"
  value       = module.compute.vm_name
}

output "vm_id" {
  description = "Virtual Machine ID"
  value       = module.compute.vm_id
}

output "nic_id" {
  description = "Network Interface ID"
  value       = module.compute.nic_id
}

# -------------------------------------------------------------------
# Security
# -------------------------------------------------------------------

output "nsg_id" {
  description = "Network Security Group ID"
  value       = module.security.nsg_id
}

output "route_table_id" {
  description = "Route Table ID"
  value       = module.routing.route_table_id
}

output "route_table_name" {
  description = "Route Table name"
  value       = module.routing.route_table_name
}

# -------------------------------------------------------------------
# Key Vault
# -------------------------------------------------------------------

output "key_vault_name" {
  description = "Key Vault name"
  value       = module.keyvault.key_vault_name
}

output "key_vault_id" {
  description = "Key Vault ID"
  value       = module.keyvault.key_vault_id
}

# -------------------------------------------------------------------
# Storage private
# -------------------------------------------------------------------

output "storage_account_name" {
  description = "Storage Account name"
  value       = module.storage_private.storage_account_name
}

output "storage_account_id" {
  description = "Storage Account ID"
  value       = module.storage_private.storage_account_id
}

output "private_endpoint_id" {
  description = "Private Endpoint ID for Blob"
  value       = module.storage_private.private_endpoint_id
}

output "private_dns_zone_id" {
  description = "Private DNS Zone ID for Blob"
  value       = module.storage_private.private_dns_zone_id
}