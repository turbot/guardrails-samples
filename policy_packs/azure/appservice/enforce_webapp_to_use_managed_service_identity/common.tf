# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce Azure App Service Web Apps to Use Managed Service Identity"
  description = "Delete Azure App Service Web Apps that do not use managed service identity."
  parent      = "tmod:@turbot/turbot#/"
}

# Azure > AppService > Enabled
resource "turbot_policy_setting" "azure_appservice_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/appServiceEnabled"
  value    = "Enabled"
}
