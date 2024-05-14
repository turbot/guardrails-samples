# AWS > RDS > DB Instance > Approved
resource "turbot_policy_setting" "aws_rds_db_instance_approved" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApproved"
  note     = "AWS CIS v3.0.0 - Control: 2.3.1"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Snapshot and delete unapproved if new"
}

# AWS > RDS > DB Instance > Approved > Usage
resource "turbot_policy_setting" "aws_rds_db_instance_approved_usage" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApprovedUsage"
  note     = "AWS CIS v3.0.0 - Control: 2.3.1"
  value    = "Approved"
}

# AWS > RDS > DB Instance > Approved > Encryption at Rest
resource "turbot_policy_setting" "aws_rds_db_instance_encryption_at_rest" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceEncryptionAtRest"
  note     = "AWS CIS v3.0.0 - Control: 2.3.1"
  value    = "AWS managed key or higher"
}

# AWS > RDS > DB Instance > Auto Minor Version Upgrade
resource "turbot_policy_setting" "aws_rds_db_instance_auto_minor_version_upgrade" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceAutoMinorVersionUpgrade"
  note     = "AWS CIS v3.0.0 - Control: 2.3.2"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# AWS > RDS > DB Instance > Publicly Accessible
resource "turbot_policy_setting" "aws_rds_db_instance_publicly_accessible" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstancePubliclyAccessible"
  note     = "AWS CIS v3.0.0 - Control: 2.3.3"
  value    = "Check: DB Instance is not publicly accessible"
  # value    = "Enforce: DB Instance is not publicly accessible"
}

