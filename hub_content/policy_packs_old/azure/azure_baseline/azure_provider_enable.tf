# Enable all Azure Services Providers within the Variables file
# More Info: https://turbot.com/v5/docs/integrations/azure/services#registering-service-providers

resource "turbot_policy_setting" "provider_registration_enable" {
  for_each = var.provider_status
  resource = turbot_smart_folder.azure_baseline.id
  type     = var.provider_registration_map[each.key]
  value    = each.value
}