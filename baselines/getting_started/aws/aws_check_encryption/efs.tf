# AWS Elastic File System (EFS) Encryption controls
# Commented out since these services are not associated to the initial mod install list


# resource "turbot_policy_setting" "aws_efs_file_system_approved" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-efs#/policy/types/fileSystemApproved"
#   value    = "Check: Approved"
# }

# resource "turbot_policy_setting" "aws_efs_file_system_encryption_at_rest" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-efs#/policy/types/fileSystemEncryptionAtRest"
#   value    = "AWS managed key or higher"
# }
