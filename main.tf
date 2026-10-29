terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.47"
    }
  }
}

#azurerm = takes control of Azure resources (network, VMs, Key Vault, etc)
provider "azurerm" {
  features {}
}

#azuread = controls Identity (users, groups, service principles)
provider "azuread" {}