# AWS > RDS > Ensure Encryption-at-Rest
resource "turbot_policy_setting" "aws_rds_encryption_at_rest" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-rds#/policy/types/instanceEncryption"
  value    = "Enforce: Enabled"
  note     = "AWS CIS v3.0.0 - Control: 2.3.1"
}

# AWS > RDS > Auto Minor Version Upgrade
resource "turbot_policy_setting" "aws_rds_auto_minor_version_upgrade" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-rds#/policy/types/autoMinorVersionUpgrade"
  value    = "Enforce: Enabled"
  note     = "AWS CIS v3.0.0 - Control: 2.3.2"
}

# AWS > RDS > Deny Public Access
resource "turbot_policy_setting" "aws_rds_deny_public_access" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-rds#/policy/types/publicAccess"
  value    = "Enforce: Denied"
  note     = "AWS CIS v3.0.0 - Control: 2.3.3"
}