# Azure > AppService > WebApp > Minimum TLS Version
resource "turbot_policy_setting" "azure_appservice_webapp_minimum_tls_version" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppMinimumTlsVersion"
  value    = "Check: TLS 1.2"
  # value    = "Enforce: TLS 1.2"
}
