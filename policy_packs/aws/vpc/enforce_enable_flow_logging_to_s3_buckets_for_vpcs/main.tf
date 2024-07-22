resource "turbot_policy_pack" "main" {
  title       = "Enforce Enable Flow Logging To S3 Buckets For VPCs"
  description = "Ensure that all network flow logs are stored securely in S3 buckets, facilitating detailed analysis, anomaly detection, and compliance with security best practices and regulatory requirements."
  akas        = ["aws_vpc_enforce_enable_flow_logging_to_s3_buckets_for_vpcs"]
}
