resource "turbot_policy_pack" "main" {
  title       = "Enforce Cost Center Tag Transform for Azure Storage Accounts"
  description = "Enforcing a consistent format for the `Cost_Center` tag key ensures that all tags are uniform, helping to keep resources organized and making tracking and management easier."
  akas        = ["azure_storage_enforce_cost_center_tag_transform_for_storage_accounts"]
}
