# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect if encryption is enabled for RDS instances"
  description = "Detect and report RDS instances that do not have encryption enabled"
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > RDS > Enabled
resource "turbot_policy_setting" "aws_rds_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-rds#/policy/types/rdsEnabled"
  value    = "Enabled"
}
