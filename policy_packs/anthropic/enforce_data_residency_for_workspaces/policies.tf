# Anthropic > Workspace > Data Residency
resource "turbot_policy_setting" "anthropic_workspace_data_residency" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/anthropic#/policy/types/workspaceDataResidency"
  value    = "Check: Enabled"
  # value    = "Enforce: Set data residency"
}

# Anthropic > Workspace > Data Residency > Allowed Geos
resource "turbot_policy_setting" "anthropic_workspace_data_residency_allowed_geos" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/anthropic#/policy/types/workspaceDataResidencyAllowedGeos"
  value    = <<-EOT
    - "us"
    EOT
}

# Anthropic > Workspace > Data Residency > Default Geo
resource "turbot_policy_setting" "anthropic_workspace_data_residency_default_geo" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/anthropic#/policy/types/workspaceDataResidencyDefaultGeo"
  value    = "us"
}
