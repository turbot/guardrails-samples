resource "turbot_policy_pack" "main" {
  title       = "Enforce Local Authentication Is Disabled for Azure AI Foundry Accounts"
  description = "Require Azure AI Foundry accounts to disable local (API key) authentication so that only Microsoft Entra ID identities can access the account."
  akas        = ["azure_aifoundry_enforce_local_auth_disabled_for_accounts"]
}
