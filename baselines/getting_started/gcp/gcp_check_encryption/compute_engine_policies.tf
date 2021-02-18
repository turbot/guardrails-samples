# Compute Engine Disk Unencrypted 

# GCP > Compute Engine > Disk > Approved
# https://turbot.com/v5/mods/turbot/gcp-computeengine/inspect#/policy/types/diskApproved
resource "turbot_policy_setting" "gcp_computeengine_disk_approved" {
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/diskApproved"
  value    = "Check: Approved"
          # "Enforce: Delete unapproved if new"
}

# GCP > Compute Engine > Disk > Approved > Encryption at Rest
# https://turbot.com/v5/mods/turbot/gcp-computeengine/inspect#/policy/types/diskApprovedEncryptionAtRest
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

# GCP > Compute Engine > Image > Approved
# https://turbot.com/v5/mods/turbot/gcp-computeengine/inspect#/policy/types/imageApproved
resource "turbot_policy_setting" "gcp_computeengine_image_approved" {
  count    = var.enable_computeengine_image_approved_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/imageApproved"
  value    = "Check: Approved"
          # "Enforce: Delete unapproved if new"
}

# GCP > Compute Engine > Image > Approved > Encryption at Rest
# https://turbot.com/v5/mods/turbot/gcp-computeengine/inspect#/policy/types/imageApprovedEncryptionAtRest
resource "turbot_policy_setting" "gcp_computeengine_image_approved_encryption_at_rest" {
  count    = var.enable_computeengine_image_approved_encryption_at_rest_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/imageApprovedEncryptionAtRest"
  value    = "Google managed key"
          # "Google managed key"
          # "Google managed key or higher"
          # "Customer managed key"
          # "Customer managed key or higher"
          # "Encryption at Rest > Customer Managed Key"
}
