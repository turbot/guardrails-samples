# Create smart folder
resource "turbot_smart_folder" "rds_audit_logging" {
  title         = var.smart_folder_title
  description   = "Smart folder that contains RDS audit logging policies"
  parent        = "tmod:@turbot/turbot#/"
}

### Enforce DB Audit Logging

# Setting RDS DB Parameters policy to check
# Check if an RDS instance's database parameters configured per policy, including audit and log parameters. 
# Currently supported for Aurora, MariaDB, MySQL, Postgres, and SQL Server RDS engine types
# AWS > RDS > DB Instance > Parameters
resource "turbot_policy_setting" "rds_db_paramaters" {
    resource = turbot_smart_folder.rds_audit_logging.id
    type = "tmod:@turbot/aws-rds#/policy/types/databaseParameters"
    value = "Check: Database parameters configured per policy"
}
# Setting RDS DB Parameters Audit Logging
# If enabled, audit trail logs are enabled for all database operations.
# AWS > RDS > DB Instance > Parameters > Audit Logging
resource "turbot_policy_setting" "rds_db_paramaters_auditlog" {
    resource = turbot_smart_folder.rds_audit_logging.id
    type = "tmod:@turbot/aws-rds#/policy/types/auditLogging"
    value = "Enabled"
}