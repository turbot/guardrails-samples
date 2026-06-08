# Azure > AI Foundry > Account > Local Auth
resource "turbot_policy_setting" "azure_aifoundry_account_local_auth" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-aifoundry#/policy/types/accountLocalAuth"
  value    = "Check: Disabled"
  # value    = "Check: Enabled"
  # value    = "Enforce: Disabled"
  # value    = "Enforce: Enabled"
}
