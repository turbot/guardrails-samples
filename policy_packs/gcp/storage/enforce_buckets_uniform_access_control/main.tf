resource "turbot_policy_pack" "main" {
  title       = "Enforce Uniform Access Control is Enabled for GCP Storage Buckets"
  description = "Ensure that uniform access control is enabled for buckets as it unifies and simplifies how you grant access to your cloud storage resources."
  akas        = ["gcp_storage_enforce_buckets_uniform_access_control"]
}
