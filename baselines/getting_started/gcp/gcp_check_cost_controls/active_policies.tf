# Simple cost control to check for aging infrastructure over X days
# Defaulting to 60 days as an example.
# Other use cases can be used for Last Modified, Attached, etc.
# More Info: https://turbot.com/v5/docs/concepts/guardrails/active

# GCP > **Service** > **Resource** > Active
# Example policy: https://turbot.com/v5/mods/turbot/gcp-computeengine/inspect#/policy/types/instanceActive
resource "turbot_policy_setting" "set_resource_active_policies" {
  for_each = var.resource_active
  resource = turbot_smart_folder.gcp_cost_controls.id
  type     = local.policy_map[each.key]
  value    = each.value
}

# GCP > Compute Engine > Instance > Active > Age
# https://turbot.com/v5/mods/turbot/gcp-computeengine/inspect#/policy/types/instanceActiveAge
resource "turbot_policy_setting" "set_resource_age_policies" {
  for_each = var.resource_active
  resource = turbot_smart_folder.gcp_cost_controls.id
  type     = local.policy_map_age[each.key]
  value    = "Force inactive if age > 60 days"
  # Skip
  # Force inactive if age > 1 day
  # Force inactive if age > 3 days
  # Force inactive if age > 7 days
  # Force inactive if age > 14 days
  # Force inactive if age > 30 days
  # Force inactive if age > 60 days
  # Force inactive if age > 90 days
  # Force inactive if age > 180 days
  # Force inactive if age > 365 days
}
