# Enabling GCP Services in Turbot
#   https://turbot.com/v5/docs/integrations/gcp/services

# Loop through var.service_status and set enable policies

# GCP > **Service** > Enabled
# Example policy: https://turbot.com/v5/mods/turbot/gcp-iam/inspect#/policy/types/iamEnabled
resource "turbot_policy_setting" "gcp_enable" {
  for_each = var.service_status
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/${each.key}#/policy/types/${local.policy_map[each.key]}"
  value    = each.value
}

# GCP > **Service** > API Enabled
# Example policy: https://turbot.com/v5/mods/turbot/gcp-iam/inspect#/policy/types/iamApiEnabled
resource "turbot_policy_setting" "gcp_api_enable" {
  for_each = var.service_status
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/${each.key}#/policy/types/${local.api_policy_map[each.key]}"
  value    = "Enforce: ${each.value}"
}
