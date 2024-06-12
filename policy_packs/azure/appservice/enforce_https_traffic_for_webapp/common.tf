# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce HTTPS Traffic for Azure App Service Web Apps"
  description = "Ensure Azure App Service web apps use HTTPS traffic."
  parent      = "tmod:@turbot/turbot#/"
}

# Azure > AppService > Enabled
resource "turbot_policy_setting" "azure_appservice_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/appServiceEnabled"
  value    = "Enabled"
}
