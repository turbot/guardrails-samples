resource "turbot_policy_pack" "main" {
  title       = "Enforce Cost Center Label Transform for GCP Storage Buckets"
  description = "Enforcing a consistent format for the `Cost_Center` label key ensures that all labels are uniform, helping to keep resources organized and making tracking and management easier."
  akas        = ["gcp_storage_enforce_cost_center_label_transform_for_buckets"]
}
