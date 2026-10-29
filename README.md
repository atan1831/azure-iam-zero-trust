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

## Why a custom role

Built-in roles like Contributor or Reader grant far more than most apps need.
This role lists exactly three read actions, so a compromised app can look
at resources but cannot change or delete anything.

## Security decisions

- Least privilege: three read-only actions, nothing else
- Secrets stay out of Git: tfstate and tfvars are in .gitignore
- Service Principal password is marked sensitive in outputs
- Humans and apps are separated: I am the only Owner, the app has a custom role

## How to run

    az login
    cp terraform.tfvars.example terraform.tfvars   # add tenant and subscription IDs
    terraform init
    terraform plan
    terraform apply
    terraform destroy                              # clean up when done

## Screenshots

(add: app registration, IAM role assignments, custom role permissions)
