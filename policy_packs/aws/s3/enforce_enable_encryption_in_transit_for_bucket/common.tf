# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce Enable Encryption in Transit for S3 Buckets"
  description = "Ensure encryption in transit is enabled for S3 buckets."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > S3 > Enabled
resource "turbot_policy_setting" "aws_s3_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3Enabled"
  value    = "Enabled"
}
