resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption in Transit Is Enabled for AWS S3 Buckets"
  description = "Encrypt data during transmission, safeguarding it from interception and unauthorized access."
  akas        = ["aws_s3_enforce_encryption_in_transit_is_enabled_for_buckets"]
}
