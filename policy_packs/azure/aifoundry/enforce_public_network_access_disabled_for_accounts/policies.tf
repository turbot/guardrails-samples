# Azure > AI Foundry > Account > Public Network Access
resource "turbot_policy_setting" "azure_aifoundry_account_public_network_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-aifoundry#/policy/types/accountPublicNetworkAccess"
  value    = "Check: Disabled"
  # value    = "Check: Enabled"
  # value    = "Enforce: Disabled"
  # value    = "Enforce: Enabled"
}
