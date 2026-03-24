# Azure Terraform Lab

## Overview
Enterprise-style Azure lab built with Terraform and GitHub Actions.

## Scope
This lab demonstrates:
- hub and spoke networking
- VNet peering
- NSG and UDR routing
- Azure Key Vault with RBAC
- Private Endpoint and Private DNS
- Terraform remote state on Azure Storage
- GitHub Actions CI and controlled apply
- Azure OIDC authentication for pipelines

## Repository structure
- `modules/` reusable Terraform modules
- `config/np.tfvars` non-production environment configuration
- `.github/workflows/` CI/CD workflows

## CI/CD
### CI workflow
Validates Terraform code with:
- `terraform fmt -check`
- `terraform init`
- `terraform validate`
- `terraform plan`

### Apply workflow
Manual non-production deployment through GitHub Actions environment `np`.

## Authentication
GitHub Actions authenticates to Azure using OIDC federation.
No long-lived Azure client secret is used.

## State management
Terraform state is stored remotely in Azure Storage.

## Notes
This repository is used as a practical Azure / Terraform / DevOps portfolio project.