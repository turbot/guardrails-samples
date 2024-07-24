resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption at Rest Is Enabled for GCP Storage Buckets"
  description = "Enforcing encryption at rest for GCP Storage Buckets is essential to protect sensitive data from unauthorized access and potential breaches by ensuring that all data is automatically encrypted before being stored."
  akas        = ["gcp_storage_enforce_encryption_at_rest_is_enabled_for_buckets"]
}
