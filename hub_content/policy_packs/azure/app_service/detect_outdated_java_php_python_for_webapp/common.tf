# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect outdated Java/PHP/Python for Web Apps"
  description = "Detect Web Apps that are running outdated Java/PHP/Python version"
  parent      = "tmod:@turbot/turbot#/"
}

# Azure > AppService > Enabled
resource "turbot_policy_setting" "azure_appservice_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/appServiceEnabled"
  value    = "Enabled"
}
