# AWS > RDS > DB Instance > Approved
resource "turbot_policy_setting" "aws_rds_db_instance_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > RDS > DB Instance > Approved > Database Engines
resource "turbot_policy_setting" "aws_rds_db_instance_approved_database_engines" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApprovedDatabaseEngines"
  value    = <<-EOT
    - "aurora"
    - "mariadb"
    - "postgresql"
  EOT
}

# AWS > RDS > DB Instance > Approved > Instance Classes
resource "turbot_policy_setting" "aws_rds_db_instance_approved_instance_classes" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApprovedInstanceClasses"
  value    = <<-EOT
    - "db.t3.*"
    - "db.m5.2xlarge"
  EOT
}
