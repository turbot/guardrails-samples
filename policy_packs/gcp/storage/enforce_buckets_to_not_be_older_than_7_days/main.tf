resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP Storage Buckets to Not Be Older Than 7 Days"
  description = "Ensure that only recently created buckets are in use, reducing the risk of using outdated configurations and improving data security and compliance with best practices"
  akas        = ["gcp_storage_enforce_buckets_to_not_be_older_than_7_days"]
}
