resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Storage Enable Cool Access Tier for Storage Accounts"
  description = "Enforcing the Cool Access Tier for Azure Storage Accounts optimizes storage costs by assigning infrequently accessed data to a lower-cost tier, ensuring efficient and cost-effective data management while maintaining data availability."
  akas        = ["azure_storage_enforce_enable_cool_access_tier_for_storage_accounts"]
}
