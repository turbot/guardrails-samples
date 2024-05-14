# Smart Folder
resource "turbot_smart_folder" "aws_cis_v300_s4_monitoring" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "AWS CIS v3.0.0 - Section 4 - Monitoring"
  description = "This section contains recommendations for configuring AWS monitoring features."
}

# AWS > CloudTrail > Enabled
resource "turbot_policy_setting" "aws_cloudtrail_enabled" {
  resource = turbot_smart_folder.aws_cis_v300_s4_monitoring.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/cloudTrailEnabled"
  value    = "Enabled"
}

# AWS > CloudWatch > Enabled
resource "turbot_policy_setting" "aws_cloudwatch_enabled" {
  resource = turbot_smart_folder.aws_cis_v300_s4_monitoring.id
  type     = "tmod:@turbot/aws-cloudwatch#/policy/types/cloudWatchEnabled"
  value    = "Enabled"
}

# AWS > Logs > Enabled
resource "turbot_policy_setting" "aws_logs_enabled" {
  resource = turbot_smart_folder.aws_cis_v300_s4_monitoring.id
  type     = "tmod:@turbot/aws-logs#/policy/types/logsEnabled"
  value    = "Enabled"
}

# AWS > Security Hub > Enabled
resource "turbot_policy_setting" "aws_security_hub_enabled" {
  resource = turbot_smart_folder.aws_cis_v300_s4_monitoring.id
  type     = "tmod:@turbot/aws-logs#/policy/types/securityHubEnabled"
  value    = "Enabled"
}