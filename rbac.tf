# Custom Role Definition
# Instead of using built-in roles, we define exactly what the SP is allowed to do
resource "azurerm_role_definition" "custom_role" {
  name        = "${var.prefix}-${var.environment}-custom-role"
  scope       = "/subscriptions/${var.subscription_id}"
  description = "Custom role with least privilege for ${var.prefix} app"

  permissions {
    # Read-only access to resources — nothing more
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.KeyVault/vaults/read",
      "Microsoft.Network/virtualNetworks/read"
    ]
    not_actions = []
  }

  assignable_scopes = [
    "/subscriptions/${var.subscription_id}"
  ]
}

# Assign Custom Role to Service Principal
# This is least privilege — the SP only gets what it needs
resource "azurerm_role_assignment" "sp_role" {
  scope              = "/subscriptions/${var.subscription_id}"
  role_definition_id = azurerm_role_definition.custom_role.role_definition_resource_id
  principal_id       = azuread_service_principal.sp.object_id
}