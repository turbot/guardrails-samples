# Smart Folder
resource "turbot_smart_folder" "azure_cis_v200_s9_app_service" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 9 - AppService"
  description = "This section covers security recommendations for Azure AppService."
}

# Azure > AppService > Enabled
resource "turbot_policy_setting" "azure_app_service_enabled" {
  resource = turbot_smart_folder.azure_cis_v200_s9_app_service.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/appServiceEnabled"
  value    = "Enabled"
}
