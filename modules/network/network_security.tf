resource "azurerm_network_security_group" "main" {
    name = "NSG-${var.name}-${var.resource_group.location}"
    resource_group_name = var.resource_group.name
    location = var.resource_group.location

    tags = var.tags
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