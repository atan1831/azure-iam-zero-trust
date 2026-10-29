# Shows Client ID after deployment
output "service_principal_client_id" {
  description = "Client ID of the Service Principal"
  value       = azuread_application.app.client_id
}

# Shows Object ID after deployment
output "service_principal_object_id" {
  description = "Object ID of the Service Principal"
  value       = azuread_service_principal.sp.object_id
}

# Password is a sensitive thing — "sensitive = true" hides it from output
output "service_principal_password" {
  description = "Password of the Service Principal"
  value       = azuread_service_principal_password.sp_password.value
  sensitive   = true
}

# Name of the custom role
output "custom_role_name" {
  description = "Name of the custom RBAC role"
  value       = azurerm_role_definition.custom_role.name
}