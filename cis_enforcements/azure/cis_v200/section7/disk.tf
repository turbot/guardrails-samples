# Azure > Compute > Disk > Encryption At Rest
resource "turbot_policy_setting" "azure_compute_disk_encryption_at_rest" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/diskEncryptionAtRest"
  note     = "Azure CIS v2.0.0 - Control: 7.3, 7.4 and 7.7"
  value    = "Check: Encryption at Rest > Disk Encryption Set"
  # value    = "Enforce: Encryption at Rest > Disk Encryption Set"
}

# Azure > Compute > Disk > Encryption At Rest > Disk Encryption Set
resource "turbot_policy_setting" "azure_compute_disk_encryption_at_rest_disk_encryption_set" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/diskEncryptionAtRestDiskEncryptionSet"
  note     = "Azure CIS v2.0.0 - Control: 7.3, 7.4 and 7.7"
  # value    = "The Disk Encryption Set ID for encryption at rest"
  value = "/subscriptions/cd4401c4-3cc8-4565-a594-839c1e345f1e/resourceGroups/test/providers/Microsoft.Compute/diskEncryptionSets/test-disk-encryption-set"
}
