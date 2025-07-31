# AWS > RDS > DB Instance > Backup Retention Period
resource "turbot_policy_setting" "backup_retention_period" {
  resource = turbot_policy_pack.enforce_backup_retention_period_for_db_instances.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceBackupRetentionPeriod"
  value    = "Check: Backup retention period"
  # value    = "Enforce: Backup retention period"
}

# AWS > RDS > DB Instance > Backup Retention Period > Days
resource "turbot_policy_setting" "backup_retention_days" {
  resource = turbot_policy_pack.enforce_backup_retention_period_for_db_instances.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceBackupRetentionPeriodDays"
  value    = 7
}
