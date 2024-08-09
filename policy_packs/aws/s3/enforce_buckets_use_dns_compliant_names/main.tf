resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS S3 Buckets Use DNS-Compliant Names"
  description = "ensures that bucket names adhere to DNS naming conventions, preventing issues with accessibility and interoperability, and ensuring smooth integration with various AWS services and applications."
  akas        = ["aws_s3_enforce_buckets_use_dns_compliant_names"]
}
