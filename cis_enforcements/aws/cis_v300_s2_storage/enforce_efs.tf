# AWS > EFS > FileSystem > Approved
resource "turbot_policy_setting" "aws_efs_file_system_approved" {
  resource = turbot_smart_folder.aws_cis_v_300_s_2_storage.id
  type     = "tmod:@turbot/aws-efs#/policy/types/fileSystemApproved"
  note     = "AWS CIS v3.0.0 - Control: 2.4.1"
  value    = "Check: Approved"
}

# AWS > EFS > FileSystem > Approved > Usage
resource "turbot_policy_setting" "aws_efs_file_system_approved_usage" {
  resource = turbot_smart_folder.aws_cis_v_300_s_2_storage.id
  type     = "tmod:@turbot/aws-efs#/policy/types/fileSystemApprovedUsage"
  note     = "AWS CIS v3.0.0 - Control: 2.4.1"
  value    = "Approved"
}

# AWS > EFS > FileSystem > Approved > Encryption at Rest
resource "turbot_policy_setting" "aws_efs_file_system_encryption_at_rest" {
  resource = turbot_smart_folder.aws_cis_v_300_s_2_storage.id
  type     = "tmod:@turbot/aws-efs#/policy/types/fileSystemEncryptionAtRest"
  note     = "AWS CIS v3.0.0 - Control: 2.4.1"
  value    = "AWS managed key or higher"
}