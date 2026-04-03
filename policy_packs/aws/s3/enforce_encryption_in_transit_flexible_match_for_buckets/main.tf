resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption in Transit with Flexible Match for AWS S3 Buckets"
  description = "Use a calculated policy to recognize effective encryption-in-transit bucket policy statements that differ only cosmetically from the canonical format (e.g. Principal as {\"AWS\": \"*\"} instead of \"*\")."
  akas        = ["aws_s3_enforce_encryption_in_transit_flexible_match_for_buckets"]
}
