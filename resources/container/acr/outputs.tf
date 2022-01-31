###
# resource outputs
###

output "id" {
  value       = azurerm_container_registry.base.id
  description = "The ID of the Container Registry."
}

output "name" {
  value       = azurerm_container_registry.base.name
  description = "The ACR name"
}