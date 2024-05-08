resource "turbot_smart_folder" "aws_cis_v300_s3_logging" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "AWS CIS v3.0.0 - Section 3 - Logging"
  description = "This section contains recommendations for configuring logging related options."
}

# AWS > CloudTrail > Enabled
resource "turbot_policy_setting" "aws_cloudtrail_cloud_trail_enabled" {
  resource = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/cloudTrailEnabled"
  value    = "Enabled"
}
