resource "turbot_policy_pack" "main" {
  title       = "Enforce Public Network Access Is Disabled for Azure Bot Service Bots"
  description = "Reduce the network attack surface of Azure Bot Service bots by requiring public network access to be disabled so the bot is only reachable through private endpoints."
  akas        = ["azure_botservice_enforce_public_network_access_disabled_for_bots"]
}
