# Azure > AppService > WebApp > HTTPS Only
resource "turbot_policy_setting" "azure_appservice_webapp_https_only" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppHttpsOnly"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
