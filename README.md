# Azure Terraform Lab

## Objective
Enterprise-grade Azure lab using Terraform modules and CI validation.

## Scope
- Resource group
- Hub / Spoke networking
- Security (NSG, rules, associations)
- Compute
- Key Vault
- Private Storage with Private Endpoint and Private DNS
- Routing / UDR

## Prerequisites
- Terraform
- Azure CLI
- Authenticated Azure session
- Remote backend already configured

## Common commands
terraform fmt -recursive
terraform validate
terraform plan
terraform apply

## Modules
- resource-group
- network
- security
- compute
- keyvault
- storage-private
- routing

## Notes
- No local state should be committed
- No tfvars file should be committed
- All naming must go through locals.naming