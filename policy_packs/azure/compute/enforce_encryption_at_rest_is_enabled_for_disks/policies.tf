# Azure > Compute > Disk > Encryption At Rest
resource "turbot_policy_setting" "azure_compute_disk_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/diskEncryptionAtRest"
  value    = "Check: Encryption at Rest > Disk Encryption Set"
  # value    = "Enforce: Encryption at Rest > Disk Encryption Set"
}

# Azure > Compute > Disk > Encryption At Rest > Disk Encryption Set
resource "turbot_policy_setting" "azure_compute_disk_encryption_at_rest_disk_encryption_set" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/diskEncryptionAtRestDiskEncryptionSet"
  # Disk Encryption Set ID to be used for Encryption at Rest
  value = "/subscriptions/cd1234c5-6cc7-8901-a234-567c8e901f2e/resourceGroups/myResourceGroup/providers/Microsoft.Compute/diskEncryptionSets/myDiskEncryptionSet"
}
