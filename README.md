# Azure Landing Zone Terraform (Enterprise Lab)

## Overview
This repository demonstrates the design and implementation of an **enterprise-grade Azure Landing Zone** using Terraform and GitHub Actions.

It is built as a **hands-on portfolio project** to showcase real-world Cloud / DevOps practices:
- Infrastructure as Code (Terraform)
- Secure CI/CD pipelines (GitHub Actions + OIDC)
- Azure governance and networking patterns
- Production-like architecture design

---

## Architecture

The platform is based on a **Hub & Spoke model** aligned with Azure best practices:

- Hub VNet (shared services)
  - Azure Firewall (egress control)
  - Shared services subnet
- Spoke VNet (workload)
  - Application subnet
  - Private Endpoints
- VNet Peering (Hub ↔ Spoke)
- User Defined Routes (forced traffic through firewall)

Security is enforced using:
- Network Security Groups (NSG)
- Private Endpoints (no public exposure)
- Azure Firewall (controlled outbound traffic)

---

## Key Features

### Infrastructure as Code
- Modular Terraform structure:
  - network
  - compute
  - security
  - key vault
  - routing
- Remote state stored in Azure Storage

### CI/CD (GitHub Actions)
- Terraform validation pipeline:
  - `terraform fmt`
  - `terraform validate`
  - `terraform plan`
- Controlled deployment via manual workflow
- Environment-based configuration (`np`, `prd`)

### Secure Authentication (OIDC)
- GitHub Actions authenticates to Azure using **OIDC federation**
- No client secrets or credentials stored in the repository
- Environment-based trust configuration in Azure Entra ID

### Networking & Security
- Hub & Spoke architecture
- Azure Firewall for egress filtering
- NSG with restrictive rules
- Private Endpoints + Private DNS

### Governance
- Azure Policy integration (location restrictions, resource compliance)
- Resource naming conventions aligned with enterprise standards
- Tagging strategy (owner, cost center, data classification)

### Observability
- Log Analytics Workspace
- Diagnostic Settings
- NSG Flow Logs analysis
- KQL queries for troubleshooting and monitoring

---

## Repository Structure

```text
modules/                # reusable Terraform modules
config/                 # environment templates (.example only)
.github/workflows/      # CI/CD pipelines