# Enable all GCP Services within the Variables file
# More Info: https://turbot.com/v5/docs/integrations/gcp/services

#Loop through var.service_status and set enable policies

resource "turbot_policy_setting" "gcp_enable" {
  for_each = var.policy_map
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/${each.key}#/policy/types/${each.value}"
  value    = var.service_status[each.key]
}

resource "turbot_policy_setting" "gcp_api_enable" {
  for_each = local.api_policy_map
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/${each.key}#/policy/types/${each.value}"
  value    = "Enforce: ${var.service_status[each.key]}"
}
