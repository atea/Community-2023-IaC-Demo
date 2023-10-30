output "frontend_subnet" {
  value       = azurerm_subnet.frontend
  description = "Frontend subnet"
}

output "backend_subnet" {
  value       = azurerm_subnet.backend
  description = "Backend subnet"
}