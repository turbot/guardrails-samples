resource "turbot_policy_pack" "main" {
  title       = "Enforce OCI Storage Buckets Are Not Publicly Accessible"
  description = "Prevent unauthorized access to data in Object Storage by keeping buckets private."
  akas        = ["oci_storage_enforce_buckets_are_not_publicly_accessible"]
}
