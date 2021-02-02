###  Compute Engine Disk Unencrypted 
resource "turbot_policy_setting" "gcp_computeengine_disk_approved" {
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/diskApproved"
  value    = "Check: Approved"
          # "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_computeengine_disk_approved_encryption_at_rest" {
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/diskApprovedEncryptionAtRest"
  value    = "Google managed key"
          # "Google managed key"
          # "Google managed key or higher"
          # "Customer managed key"
          # "Customer managed key or higher"
          # "Encryption at Rest > Customer Managed Key"
}


###  Compute Engine Image Unencrypted 
resource "turbot_policy_setting" "gcp_computeengine_image_approved" {
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/imageApproved"
  value    = "Check: Approved"
          # "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_computeengine_image_approved_encryption_at_rest" {
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/imageApprovedEncryptionAtRest"
  value    = "Google managed key"
          # "Google managed key"
          # "Google managed key or higher"
          # "Customer managed key"
          # "Customer managed key or higher"
          # "Encryption at Rest > Customer Managed Key"
}