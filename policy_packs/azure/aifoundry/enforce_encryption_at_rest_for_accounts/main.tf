resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption at Rest for Azure AI Foundry Accounts"
  description = "Protect data written to Azure AI Foundry accounts by requiring a specific encryption at rest posture, such as a customer managed key."
  akas        = ["azure_aifoundry_enforce_encryption_at_rest_for_accounts"]
}
