# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest

# AWS > EFS > FileSystem > Approved
# https://turbot.com/v5/mods/turbot/aws-efs/inspect#/policy/types/fileSystemApproved
resource "turbot_policy_setting" "aws_efs_file_system_approved" {
  count    = enable_efs_filesystem_approved_policies ? 1 : 0
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-efs#/policy/types/fileSystemApproved"
  value    = "Check: Approved"
}

# AWS > EFS > FileSystem > Approved > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-efs/inspect#/policy/types/fileSystemEncryptionAtRest
resource "turbot_policy_setting" "aws_efs_file_system_encryption_at_rest" {
  count    = enable_efs_filesystem_encryption_policies ? 1 : 0  
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-efs#/policy/types/fileSystemEncryptionAtRest"
  value    = "AWS managed key or higher"
}
