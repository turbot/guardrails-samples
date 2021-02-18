# Storage Bucket Unencrypted -- can be repaired without having to terminate the resource (direct policy vs under Approved)

# GCP > Storage > Bucket > Encryption at Rest
# https://turbot.com/v5/mods/turbot/gcp-storage/inspect#/policy/types/bucketEncryptionAtRest
resource "turbot_policy_setting" "gcp_storage_bucket_encryption_at_rest" {
  count    = var.enable_storage_bucket_encryption_at_rest_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketEncryptionAtRest"
  value    = "Check: Google managed key"
          # "Skip",
          # "Check: Google managed key",
          # "Check: Google managed key or higher",
          # "Check: Customer managed key",
          # "Check: Encryption at Rest > Customer Managed Key",
          # "Enforce: Google managed key",
          # "Enforce: Google managed key or higher",
          # "Enforce: Customer managed key",
          # "Enforce: Encryption at Rest > Customer Managed Key"
}
