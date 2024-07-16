# AWS > S3 > Bucket > Access Logging
resource "turbot_policy_setting" "aws_s3_bucket_access_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLogging"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled to Access Logging > Bucket"
}

# AWS > S3 > Bucket > Access Logging > Bucket
resource "turbot_policy_setting" "aws_s3_bucket_access_logging_bucket" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLoggingBucket"
  value    = "testbucket"
}

# AWS > S3 > Bucket > Access Logging > Bucket > Key Prefix
resource "turbot_policy_setting" "aws_s3_bucket_access_logging_bucket_prefix" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLoggingBucketPrefix"
  value    = "finance/123456789012/testbucket/"
}
