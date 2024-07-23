resource "turbot_smart_folder" "baseline" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to apply the s3 policy settings"
  parent        = "tmod:@turbot/turbot#/"
}
# Setting value to "Approved if AWS > S3 > Enabled" to approve a bucket if s3 service is enabled
# AWS > S3 > Bucket > Approved > Usage
resource "turbot_policy_setting" "s3_bucket_approved_usage" {
  resource   = turbot_smart_folder.baseline.id
  type       = "tmod:@turbot/aws-s3#/policy/types/bucketApprovedUsage"
  value      = "Approved if AWS > S3 > Enabled"
}

# Setting value to "Enforce: Delete unapproved if new and empty" to delete a bucket if it is unapproved & new
# AWS > S3 > Bucket > Approved
# Note: The approved regions is set to default, which uses the default approved regions for s3 service (AWS > S3 > Approved Regions [Default])
# You can change the approved regions policy from "AWS > S3 > Bucket > Approved > Regions" if desired
resource "turbot_policy_setting" "s3_bucket_approved" {
  resource   = turbot_smart_folder.baseline.id
  type       = "tmod:@turbot/aws-s3#/policy/types/bucketApproved"
  value      = "Enforce: Delete unapproved if new and empty"
}

# Setting value to "Active if last modified <= 90 days" to make a bucket active if it is modified within last 90 days
# AWS > S3 > Bucket > Active > Last Modified
resource "turbot_policy_setting" "s3_bucket_active_lastModified" {
  resource   = turbot_smart_folder.baseline.id
  type       = "tmod:@turbot/aws-s3#/policy/types/bucketActiveLastModified"
  value      = "Active if last modified <= 90 days"
}

# Setting value to "Enforce: Delete inactive with 90 days warning" to delete a bucket with a warning for 90 days if it is inactive
# AWS > S3 > Bucket > Active
resource "turbot_policy_setting" "s3_bucket_active" {
  resource   = turbot_smart_folder.baseline.id
  type       = "tmod:@turbot/aws-s3#/policy/types/bucketActive"
  value      = "Enforce: Delete inactive with 90 days warning"
}

# Setting value to "Check: Usage <= 85% of Limit" to give alarm when the total numbers of buckets reaches 85% of its quota
# AWS > S3 > Bucket > Usage
# The resource limit is set to the maximum limit given by AWS by default.
# You can change the limit from "AWS > S3 > Bucket > Usage > Limit"
resource "turbot_policy_setting" "s3_bucket_usage" {
  resource   = turbot_smart_folder.baseline.id
  type       = "tmod:@turbot/aws-s3#/policy/types/bucketUsage"
  value      = "Check: Usage <= 85% of Limit"
}

# Setting value to "Enforce: Enable" to enable versioning for buckets
# AWS > S3 > Bucket > Versioning
resource "turbot_policy_setting" "s3_bucket_versioning" {
  resource   = turbot_smart_folder.baseline.id
  type       = "tmod:@turbot/aws-s3#/policy/types/bucketVersioning"
  value      = "Enforce: Enabled"
}