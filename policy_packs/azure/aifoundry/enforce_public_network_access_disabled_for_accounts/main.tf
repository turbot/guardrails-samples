resource "turbot_policy_pack" "main" {
  title       = "Enforce Public Network Access Is Disabled for Azure AI Foundry Accounts"
  description = "Reduce the network attack surface of Azure AI Foundry accounts by requiring public network access to be disabled so the account is only reachable through private endpoints."
  akas        = ["azure_aifoundry_enforce_public_network_access_disabled_for_accounts"]
}
