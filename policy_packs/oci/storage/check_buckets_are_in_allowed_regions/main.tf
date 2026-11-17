resource "turbot_policy_pack" "main" {
  title       = "Check If OCI Storage Buckets Are in Allowed Regions"
  description = "Support data residency and sovereignty requirements by alarming on Object Storage buckets created outside allowed regions."
  akas        = ["oci_storage_check_buckets_are_in_allowed_regions"]
}
