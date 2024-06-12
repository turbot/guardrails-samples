# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce Block Public Access on S3 Buckets"
  description = "Ensure block public access settings is enabled for S3 buckets."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > S3 > Enabled
resource "turbot_policy_setting" "aws_s3_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3Enabled"
  value    = "Enabled"
}
