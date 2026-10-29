# Get infro from current Azure AD tenent
data "azuread_client_config" "current" {}

# Creates app in Entra ID
# Application = identitet, like "registration" in the system
resource "azuread_application" "app" {
  display_name = "${var.prefix}-${var.environment}-app"
}

# Create Service Principal for that app
# Service Principal = robot account which is used instead of a human
resource "azuread_service_principal" "sp" {
  client_id = azuread_application.app.client_id
}

# Creates pass for Service Principal
# SP cant authenticate without a pass
resource "azuread_service_principal_password" "sp_password" {
  service_principal_id = azuread_service_principal.sp.id
  end_date             = "2027-01-01T00:00:00Z"
}