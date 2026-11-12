resource "turbot_policy_pack" "main" {
  title       = "Enforce Versioning Is Enabled for OCI Storage Buckets"
  description = "Protect Object Storage data against accidental deletion and overwrites by keeping previous versions of objects."
  akas        = ["oci_storage_enforce_versioning_is_enabled_for_buckets"]
}
