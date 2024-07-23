resource "turbot_policy_pack" "main" {
  title       = "Enforce Name for AWS S3 Buckets Is DNS Compliant"
  description = "ensures that bucket names adhere to DNS naming conventions, preventing issues with accessibility and interoperability, and ensuring smooth integration with various AWS services and applications."
  akas        = ["aws_s3_enforce_name_for_buckets_is_dns_compliant"]
}
