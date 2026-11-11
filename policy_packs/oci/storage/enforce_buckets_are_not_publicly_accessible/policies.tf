# OCI > Storage > Bucket > Public Access
resource "turbot_policy_setting" "oci_storage_bucket_public_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/oci-storage#/policy/types/bucketPublicAccess"
  value    = "Check: Private"
  # value    = "Enforce: Private"
}
