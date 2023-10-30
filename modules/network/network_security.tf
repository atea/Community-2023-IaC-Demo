resource "azurerm_network_security_group" "main" {
    name = "NSG-${var.name}-${var.resource_group.location}"
    resource_group_name = var.resource_group.name
    location = var.resource_group.location

    tags = var.tags
}

resource "azurerm_network_security_rule" "in_allow_frontend_web" {
    name = "in_allow_frontend_web"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_port_range = "*"
    destination_port_ranges = ["80", "443"]
    source_address_prefix = "Internet"
    destination_address_prefix = local.subnets[0]

    resource_group_name = var.resource_group.name
    network_security_group_name = azurerm_network_security_group.main.name
}

data "http" "ipinfo" {
  url = "https://ipinfo.io"
}

resource "azurerm_network_security_rule" "in_allow_management" {
    name = "in_allow_management"
    priority = 3000
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_port_range = "*"
    destination_port_ranges = ["22", "3389"]
    source_address_prefix = format("%s/32", jsondecode(data.http.ipinfo.response_body).ip)
    destination_address_prefix = "*"

    resource_group_name = var.resource_group.name
    network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_network_security_rule" "in_deny_all" {
    name = "in_deny_all"
    priority = 4096
    direction = "Inbound"
    access = "Deny"
    protocol = "*"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix = "*"

    resource_group_name = var.resource_group.name
    network_security_group_name = azurerm_network_security_group.main.name
}