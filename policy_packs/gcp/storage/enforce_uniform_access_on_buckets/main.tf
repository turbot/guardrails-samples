resource "turbot_policy_pack" "main" {
  title       = "Enforce Uniform Access is Enabled for GCP Storage Buckets"
  description = "Ensure consistent and centralized management of access permissions, reducing the risk of unauthorized access and potential data breaches."
  akas        = ["gcp_storage_enforce_uniform_access_on_buckets"]
}
