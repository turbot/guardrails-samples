# S3 Access Logging smart folder
resource "turbot_smart_folder" "s3_access_logs" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to set the S3 Access Logging policies"
  parent        = "tmod:@turbot/turbot#/"
}

# Create a policy that sets bucket to ship access logs to. This uses the variable access_logging_bucket
resource "turbot_policy_setting" "s3_ship_logs" {
  resource = turbot_smart_folder.s3_access_logs.id
  type = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLoggingBucket"
  value = var.access_logging_bucket
}

# Create a policy that defines the AWS S3 log key prefix. This uses the variable log_prefix

resource "turbot_policy_setting" "s3_log_prefix" {
  resource = turbot_smart_folder.s3_access_logs.id
  type = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLoggingBucketPrefix"
  value = var.log_prefix
}

# Enforce S3 Access Logging. This policy is being set to Enforce: Enabled to Access Logging > Bucket.
resource "turbot_policy_setting" "s3_access_logging" {
    resource = turbot_smart_folder.s3_access_logs.id
    type = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLogging"
    value = "Enforce: Enabled to Access Logging > Bucket"
}