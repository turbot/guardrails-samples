resource "turbot_policy_pack" "main" {
  title       = "Check DNS Compliance for S3 Bucket Names"
  description = "Ensure that S3 bucket names are DNS compliant to maintain compatibility and avoid potential issues."
  akas        = ["aws_s3_check_dns_compliance_for_bucket_names"]
}