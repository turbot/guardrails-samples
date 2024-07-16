resource "turbot_policy_pack" "main" {
  title       = "Enforce Uniform Access Control is Enabled for GCP Storage Buckets"
  description = "Ensure that uniform access control is enabled for buckets, which ensure consistent and centralized management of access permissions, reducing the risk of unauthorized access and potential data breaches."
  akas        = ["gcp_storage_enforce_uniform_access_on_buckets"]
}
