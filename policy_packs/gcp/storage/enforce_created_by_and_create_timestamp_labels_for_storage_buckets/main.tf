resource "turbot_policy_pack" "main" {
  title       = "Enforce createdBy and createTimestamp Labels for GCP Storage Buckets"
  description = "Enforcing the use of createdBy and createTimestamp labels provide critical metadata that helps in identifying the origin and creation time of storage buckets."
  akas        = ["gcp_storage_enforce_created_by_and_create_timestamp_labels_for_storage_buckets"]
}
