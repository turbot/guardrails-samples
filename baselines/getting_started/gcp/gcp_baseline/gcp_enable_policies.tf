# Enable all GCP Services within the Variables file
# More Info: https://turbot.com/v5/docs/integrations/gcp/services

# Loop through var.service_status and set enable policies

# GCP > **Service** > Enabled
# Example policy: https://turbot.com/v5/mods/turbot/gcp-iam/inspect#/policy/types/iamEnabled
resource "turbot_policy_setting" "gcp_enable" {
  for_each = local.policy_map
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/${each.key}#/policy/types/${each.value}"
  value    = var.service_status[each.key]
}

# GCP > **Service** > API Enabled
# Example policy: https://turbot.com/v5/mods/turbot/gcp-iam/inspect#/policy/types/iamApiEnabled
resource "turbot_policy_setting" "gcp_api_enable" {
  for_each = local.api_policy_map
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/${each.key}#/policy/types/${each.value}"
  value    = "Enforce: ${var.service_status[each.key]}"
}
