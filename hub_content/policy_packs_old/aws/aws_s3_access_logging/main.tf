# Smart Folder Definition
resource "turbot_smart_folder" "s3_access_logs" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# To get started, the baseline assumes a Check: mode to start
# Edit the template below to meet your requirements.

# AWS > S3 > Bucket > Access Logging
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketAccessLogging
resource "turbot_policy_setting" "s3_access_logging" {
    resource = turbot_smart_folder.s3_access_logs.id
    type = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLogging"
    value = "Check: Enabled to Access Logging > Bucket"
            # "Skip"
            # "Check: Disabled"
            # "Check: Enabled"
            # "Check: Enabled to Access Logging > Bucket"
            # "Enforce: Disabled"
            # "Enforce: Enabled to Access Logging > Bucket"
}

/* # Enable if not using the Turbot defaults for log bucket and prefix
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
*/