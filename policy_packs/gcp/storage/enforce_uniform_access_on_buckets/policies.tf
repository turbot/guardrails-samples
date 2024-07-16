# GCP > Storage > Bucket > Access Control
resource "turbot_policy_setting" "gcp_storage_bucket_access_control" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketAccessControl"
  value    = "Check: Uniform"
  #  value    = "Enforce: Uniform"
}