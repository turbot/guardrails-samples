resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption at Rest Is Enabled for AWS S3 Buckets"
  description = "Safeguard sensitive data that is stored in the S3 buckets, protecting it from unauthorized access and potential breaches."
  akas        = ["aws_s3_enforce_encryption_at_rest_is_enabled_for_buckets"]
}
