# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce Secure TLS Version for Azure App Service Web Apps"
  description = "Ensure Azure App Service web apps use a secure TLS version - 1.2."
  parent      = "tmod:@turbot/turbot#/"
}

# Azure > AppService > Enabled
resource "turbot_policy_setting" "azure_appservice_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/appServiceEnabled"
  value    = "Enabled"
}
