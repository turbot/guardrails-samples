resource "turbot_policy_pack" "main" {
  title       = "Enforce Restricted Outbound Network Access for Azure AI Foundry Accounts"
  description = "Limit where Azure AI Foundry accounts can connect by restricting outbound network access to an explicit list of allowed FQDNs."
  akas        = ["azure_aifoundry_enforce_outbound_network_access_for_accounts"]
}
