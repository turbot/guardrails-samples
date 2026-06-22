# Azure > Bot Service > Bot > Public Network Access
resource "turbot_policy_setting" "azure_botservice_bot_public_network_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-botservice#/policy/types/botPublicNetworkAccess"
  value    = "Check: Disabled"
  # value    = "Enforce: Disabled"
}
