# GCP > Storage > Bucket > Encryption at Rest
resource "turbot_policy_setting" "gcp_storage_bucket_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketEncryptionAtRest"
  value    = "Check: Google managed key or higher"
  # value    = "Enforce: Google managed key or higher"
}
