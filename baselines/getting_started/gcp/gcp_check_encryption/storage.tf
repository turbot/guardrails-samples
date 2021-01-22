###  Storage Bucket Unencrypted -- can be repaired without having to terminate the resource (direct policy vs under Approved)

resource "turbot_policy_setting" "gcp_storage_bucket_encryption_at_rest" {
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
