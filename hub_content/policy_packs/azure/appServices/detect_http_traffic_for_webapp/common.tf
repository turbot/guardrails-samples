# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect HTTP traffic for Web Apps"
  description = "Detect HTTP traffic status for Web Apps"
  parent      = "tmod:@turbot/turbot#/"
}

# Azure > AppService > Enabled
resource "turbot_policy_setting" "azure_appservice_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/appServiceEnabled"
  value    = "Enabled"
}
