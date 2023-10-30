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

resource "azurerm_resource_group" "demo" {
  name     = "RG-Community-Demo"
  location = var.location

  tags = local.tags
}

module "network" {
  source         = "./modules/network"
  name           = "demo"
  resource_group = azurerm_resource_group.demo
  address_space  = "10.42.0.0/24"

  tags = local.tags
}

module "webserver" {
  source           = "./modules/linuxvm"
  name             = "web01"
  resource_group   = azurerm_resource_group.demo
  subnet_id        = module.network.frontend_subnet.id
  enable_public_ip = true

  tags = local.tags
}

module "backend" {
  source           = "./modules/linuxvm"
  name             = "backend01"
  resource_group   = azurerm_resource_group.demo
  subnet_id        = module.network.frontend_subnet.id
  enable_public_ip = false

  tags = local.tags
}