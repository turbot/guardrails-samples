# GCP > Storage > Bucket > Encryption at Rest
resource "turbot_policy_setting" "gcp_storage_bucket_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketEncryptionAtRest"
  # value    = "Check: Google managed key"
  value    = "Check: Customer managed key"
  # value    = "Enforce: Google managed key"
  # value    = "Enforce: Encryption at Rest > Customer Managed Key" 
}

# GCP > Storage > Bucket > Encryption at Rest > Customer Managed Key
resource "turbot_policy_setting" "gcp_storage_bucket_encryption_at_rest_customer_managed_key" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketEncryptionAtRestCustomerManagedKey"
  # Your KMS crypto key
  value = "projects/acmeproject/locations/global/keyRings/acmekeyring/cryptoKeys/acmekey/cryptoKeyVersions/1"
}
