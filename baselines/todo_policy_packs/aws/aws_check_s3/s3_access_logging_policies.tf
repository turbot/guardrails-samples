# AWS > S3 > Bucket > Access Logging
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketAccessLogging
resource "turbot_policy_setting" "aws_s3_bucket_access_logging" {
  count    = var.enable_s3_access_logging_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLogging"
  value    = "Check: Enabled"
}
