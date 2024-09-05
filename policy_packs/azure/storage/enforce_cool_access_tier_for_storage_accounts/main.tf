resource "turbot_policy_pack" "main" {
  title       = "Enforce Cool Access Tier for Azure Storage Accounts"
  description = "Ensure that infrequently accessed data is stored in a cost-effective manner, reducing overall storage expenses while maintaining accessibility, and aligning with best practices for data management and cost optimization."
  akas        = ["azure_storage_enforce_cool_access_tier_for_storage_accounts"]
}
