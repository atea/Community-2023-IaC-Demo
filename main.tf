terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.45.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.78.0"
    }
  }
}

provider "azuread" {}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

data "azuread_user" "current" {
  object_id = data.azurerm_client_config.current.object_id
}

locals {
  tags = {
    created-by           = data.azuread_user.current.display_name
    managed-by-terraform = true
  }
}