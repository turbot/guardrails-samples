# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect if encryption at rest is enabled for S3 buckets"
  description = "Detect and report S3 buckets that have encryption at rest enabled"
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > S3 > Enabled
resource "turbot_policy_setting" "aws_s3_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3Enabled"
  value    = "Enabled"
}
