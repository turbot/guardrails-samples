# OCI > Storage > Bucket > Versioning
resource "turbot_policy_setting" "oci_storage_bucket_versioning" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/oci-storage#/policy/types/bucketVersioning"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
