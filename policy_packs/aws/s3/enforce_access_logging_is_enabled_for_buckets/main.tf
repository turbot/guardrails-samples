resource "turbot_policy_pack" "main" {
  title       = "Enforce Access Logging Is Enabled for Buckets"
  description = "Ensure that S3 bucket access logging is enabled and follows a specific naming convention for enhanced security and auditing."
  akas        = ["aws_s3_enforce_access_logging_is_enabled_for_buckets"]
}
