# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Correct insecure TLS version for Web Apps"
  description = "Correct Web Apps that are using insecure TLS versions - 1.0 and 1.1"
  parent      = "tmod:@turbot/turbot#/"
}

# Azure > AppService > Enabled
resource "turbot_policy_setting" "azure_appservice_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/appServiceEnabled"
  value    = "Enabled"
}
