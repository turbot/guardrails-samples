resource "turbot_policy_pack" "main" {
  title       = "Enforce Creator and Creation Time Labels for GCP Storage Buckets"
  description = "Enforcing the use of Creator and Creation Time labels provide critical metadata that helps in identifying the origin and creation time of storage buckets."
  akas        = ["gcp_storage_enforce_creator_and_creationtime_labels_for_buckets"]
}
