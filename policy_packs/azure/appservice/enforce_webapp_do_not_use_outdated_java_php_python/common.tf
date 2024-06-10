# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce App Service web apps do not use outdated Java/PHP/Python versions"
  description = "Delete App Service web apps that use outdated Java/PHP/Python versions."
  parent      = "tmod:@turbot/turbot#/"
}

# Azure > AppService > Enabled
resource "turbot_policy_setting" "azure_appservice_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/appServiceEnabled"
  value    = "Enabled"
}
