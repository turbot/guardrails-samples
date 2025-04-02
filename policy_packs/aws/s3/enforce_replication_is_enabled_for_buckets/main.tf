resource "turbot_policy_pack" "main" {
  title       = "AWS S3 Enforce Replication Is Enabled for Buckets"
  description = "Enforce that AWS S3 Buckets have at least one replication rule enabled."
  akas        = ["aws_s3_enforce_replication_is_enabled_for_buckets"]
}
