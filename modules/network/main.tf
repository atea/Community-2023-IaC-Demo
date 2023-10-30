terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
    http = {
      source  = "hashicorp/http"
      version = ">= 3.0.0"
    }
  }
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.name}-${var.resource_group.location}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  address_space = [var.address_space]

  tags = var.tags
}

locals {
  subnets = cidrsubnets(var.address_space, 4, 4)
}

resource "azurerm_subnet" "frontend" {
  name                 = "SN-Frontend"
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.subnets[0]]
}

resource "azurerm_subnet_network_security_group_association" "frontend" {
  subnet_id                 = azurerm_subnet.frontend.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_subnet" "backend" {
  name                 = "SN-Backend"
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.subnets[1]]
}

resource "azurerm_subnet_network_security_group_association" "backend" {
  subnet_id                 = azurerm_subnet.backend.id
  network_security_group_id = azurerm_network_security_group.main.id
}