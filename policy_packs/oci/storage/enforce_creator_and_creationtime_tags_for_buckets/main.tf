resource "turbot_policy_pack" "main" {
  title       = "Enforce Creator and Creation Time Tags for OCI Storage Buckets"
  description = "Enforcing Creator and Creation Time tags provides critical metadata that helps identify the origin and creation time of Object Storage buckets."
  akas        = ["oci_storage_enforce_creator_and_creationtime_tags_for_buckets"]
}
