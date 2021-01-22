# Enable all Azure Services within the Variables file
# More Info: https://turbot.com/v5/docs/integrations/azure/services#enabling-services

#Loop through var.service_status and set enable policies
resource "turbot_policy_setting" "azure_enable" {
  for_each = var.enabled_policy_map
  resource = turbot_smart_folder.azure_baseline.id
  type     = "tmod:@turbot/${each.key}#/policy/types/${each.value}"
  value    = "Enabled"
}