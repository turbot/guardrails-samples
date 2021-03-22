# More Info: https://turbot.com/v5/docs/concepts/guardrails/active

# GCP > Compute Engine > Disk > Active
# https://turbot.com/v5/mods/turbot/gcp-computeengine/inspect#/policy/types/diskActive
resource "turbot_policy_setting" "gcp_computeengine_disk_active" {
  count    = var.gcp_computeengine_disk_active_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_cost_controls.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/diskActive"
  value    = "Check: Active"
}

# GCP > Compute Engine > Disk > Active > Attached
# https://turbot.com/v5/mods/turbot/gcp-computeengine/inspect#/policy/types/diskActiveAttached
resource "turbot_policy_setting" "gcp_computeengine_disk_active_attached" {
  count    = var.gcp_computeengine_disk_active_attached_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_cost_controls.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/diskActiveAttached"
  value    = "Force inactive if unattached"
}
