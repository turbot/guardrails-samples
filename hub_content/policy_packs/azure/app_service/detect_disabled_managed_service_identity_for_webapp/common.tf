# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect disabled managed service identities for Web Apps"
  description = "Detect managed service identities that are disabled for Web Apps"
  parent      = "tmod:@turbot/turbot#/"
}

# Azure > AppService > Enabled
resource "turbot_policy_setting" "azure_appservice_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/appServiceEnabled"
  value    = "Enabled"
}
