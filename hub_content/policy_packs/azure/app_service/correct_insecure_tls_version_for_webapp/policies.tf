# Azure > AppService > WebApp > Approved
resource "turbot_policy_setting" "azure_appservice_webapp_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > AppService > WebApp > webAppInsecureTlsVersion
resource "turbot_policy_setting" "azure_appservice_webapp_webAppInsecureTlsVersion" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppMinimumTlsVersion"
  value    = "Check: TLS 1.2"
  # value    = "Enforce: TLS 1.2"
}
