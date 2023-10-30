terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

resource "azurerm_public_ip" "main" {
  count               = var.enable_public_ip == true ? 1 : 0
  name                = "ip-${var.name}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  allocation_method   = "Dynamic"

  tags = var.tags
}

resource "azurerm_network_interface" "main" {
  name                = "nic-${var.name}"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.enable_public_ip == true ? azurerm_public_ip.main[0].id : null
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "vm-${var.name}"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.main.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = var.tags
}