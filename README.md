# Azure IAM & Zero Trust (Terraform)

Identity and access management for Azure, built with Terraform.
Focus: least privilege.

## What it builds

| Resource | Purpose |
|---|---|
| Entra ID app registration | Identity for an application |
| Service Principal | Non-human account the app uses to sign in |
| Custom RBAC role | Read-only: resource groups, Key Vault, VNet |
| Role assignment | Gives the Service Principal only that custom role |
| Conditional Access policy | Require MFA for all users (report-only, not deployed) |

## Why a custom role

Built-in roles like Contributor or Reader grant far more than most apps need.
This role lists exactly three read actions, so a compromised app can look
at resources but cannot change or delete anything.

## Security decisions

- Least privilege: three read-only actions, nothing else
- Secrets stay out of Git: tfstate and tfvars are in .gitignore
- Service Principal password is marked sensitive in outputs
- Humans and apps are separated: I am the only Owner, the app has a custom role

## Requirements

- Terraform >= 1.5.0
- Azure CLI, signed in with `az login`
- An Azure subscription where you can create custom roles (Owner or User Access Administrator)
- Entra ID P1 licence, only if you want to deploy the Conditional Access policy

## How to run

    az login
    cp terraform.tfvars.example terraform.tfvars   # add tenant and subscription IDs
    terraform init
    terraform plan
    terraform apply
    terraform destroy                              # clean up when done

## Screenshots

**IAM role assignments**

<img width="1103" height="658" alt="IAM role assignments" src="https://github.com/user-attachments/assets/a8f28289-fbe3-4686-9b38-47c53b05e3b5" />

**Custom role permissions**

<img width="1425" height="722" alt="Custom role permissions" src="https://github.com/user-attachments/assets/128a152a-1cfa-47c1-b80c-808035398d1c" />

**App registration**

<img width="1678" height="873" alt="App registration" src="https://github.com/user-attachments/assets/cff6bf7a-5716-4067-94f8-d106da451654" />

## Conditional Access

`conditional_access.tf` defines a policy requiring MFA for all users,
in report-only mode, with my own account excluded to prevent lockout.

Conditional Access requires an Entra ID P1 licence,
which this tenant does not have, so it was not deployed.
The configuration passes `terraform validate`.

## What I learned

- azurerm manages Azure resources, azuread manages identities
- A Service Principal is a non-human account for apps
- Custom roles beat broad built-in roles for least privilege
- New subscriptions can fail on provider registration; on azurerm 3.x, `skip_provider_registration = true` in the provider block is a workaround
- Conditional Access policies should start in report-only mode
