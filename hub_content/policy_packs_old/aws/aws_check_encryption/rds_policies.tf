# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest

# AWS > RDS > DB Instance > Approved
# https://turbot.com/v5/mods/turbot/aws-rds/inspect#/policy/types/dbInstanceApproved
resource "turbot_policy_setting" "db_instancce_approved" {
  count    = var.enable_rds_instance_approved_policies ? 1 : 0
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApproved"
  value    = "Check: Approved"
}
# AWS > RDS > DB Instance > Approved > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-rds/inspect#/policy/types/dbInstanceEncryptionAtRest
resource "turbot_policy_setting" "db_instance_approved_encryption" {
  count    = var.enable_rds_instance_encryption_policies ? 1 : 0
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceEncryptionAtRest"
  value    = "AWS managed key or higher"
}

# AWS > RDS > DB Snapshot [Manual] > Approved
# https://turbot.com/v5/mods/turbot/aws-rds/inspect#/policy/types/dbSnapshotManualEncryptionAtRest
resource "turbot_policy_setting" "db_snapshot_approved" {
  count    = var.enable_rds_manualsnapshot_approved_policies ? 1 : 0
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbSnapshotManualApproved"
  value    = "Check: Approved"
}

# AWS > RDS > DB Instance > Approved > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-rds/inspect#/policy/types/dbInstanceEncryptionAtRest
resource "turbot_policy_setting" "db_snapshot_approved_encryption" {
  count    = var.enable_rds_manualsnapshot_encryption_policies ? 1 : 0
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbSnapshotManualEncryptionAtRest"
  value    = "AWS managed key or higher"
}

