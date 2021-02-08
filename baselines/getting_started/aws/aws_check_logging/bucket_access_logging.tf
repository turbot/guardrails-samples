# S3 Bucket Access Logging Check
# AWS > S3 > Bucket > Access Logging
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketAccessLogging
resource "turbot_policy_setting" "aws_s3_bucket_access_logging" {
  count    = var.enable_aws_s3_bucket_access_logging ? 1 : 0
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLogging"
  value    = "Check: Enabled"
}