## Ensure encryption on Backup Vault Resources
# Commented out since these services are not associated to the initial mod install list

# AWS > Backup > Backup Vault > Approved
# https://turbot.com/v5/mods/turbot/aws-backup/inspect#/control/types/backupVaultApproved
# resource "turbot_policy_setting" "aws_backup_vault_approved" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-backup#/policy/types/backupVaultApproved"
#   value    = "Check: Approved"
# }

# AWS > Backup > Backup Vault > Approved > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-backup/inspect#/policy/types/backupVaultEncryptionAtRest
# resource "turbot_policy_setting" "aws_backup_vault_encryption_at_rest" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-backup#/policy/types/backupVaultEncryptionAtRest"
#   value    = "AWS managed key or higher"
# }
