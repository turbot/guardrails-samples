resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP Storage Buckets to Not Be Older Than 7 Days"
  description = "Enforcing the deletion of inactive buckets ensures that unused storage does not accumulate unnecessarily, which can help mitigate potential vulnerabilities and optimize costs"
  akas        = ["gcp_storage_enforce_buckets_to_not_be_older_than_7_days"]
}
