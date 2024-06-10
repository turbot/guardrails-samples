# Azure > AppService > WebApp > HTTPS Only
resource "turbot_policy_setting" "azure_appservice_webapp_https_only" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppHttpsOnly"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
