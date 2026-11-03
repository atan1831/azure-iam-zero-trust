# Conditional Access: require MFA for all users
# report-only first, so it logs what would happen without blocking anyone
resource "azuread_conditional_access_policy" "require_mfa" {
  display_name = "${var.prefix}-${var.environment}-require-mfa"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      included_users = ["All"]
      # exclude yourself so a mistake can't lock you out
      excluded_users = [data.azuread_client_config.current.object_id]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["mfa"]
  }
}