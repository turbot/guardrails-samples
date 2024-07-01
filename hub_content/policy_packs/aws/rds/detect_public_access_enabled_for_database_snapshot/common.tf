# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect if public access is enabled for RDS database snapshot"
  description = "Detect and report RDS database snapshot that have public access enabled"
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > RDS > Enabled
resource "turbot_policy_setting" "aws_rds_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-rds#/policy/types/rdsEnabled"
  value    = "Enabled"
}
