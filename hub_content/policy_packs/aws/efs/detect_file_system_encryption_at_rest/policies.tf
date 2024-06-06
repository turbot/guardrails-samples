# AWS > EFS > FileSystem > Approved
resource "turbot_policy_setting" "aws_efs_file_system_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-efs#/policy/types/fileSystemApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > EFS > FileSystem > Approved > Encryption at Rest
resource "turbot_policy_setting" "aws_efs_file_system_approved_encryption_at_rest" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-efs#/policy/types/fileSystemEncryptionAtRest"
  value    = "AWS managed key or higher"
  # value = "AWS managed key"
  # value = "Customer managed key"
  # value = "Encryption at Rest > Customer Managed Key"
  # value = "None or higher"
}
