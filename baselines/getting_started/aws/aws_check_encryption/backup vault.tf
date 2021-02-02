## Ensure encryption on Backup Vault Resources
# Commented out since these services are not associated to the initial mod install list

# resource "turbot_policy_setting" "aws_backup_vault_approved" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-backup#/policy/types/backupVaultApproved"
#   value    = "Check: Approved"
# }

# resource "turbot_policy_setting" "aws_backup_vault_encryption_at_rest" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-backup#/policy/types/backupVaultEncryptionAtRest"
#   value    = "AWS managed key or higher"
# }
