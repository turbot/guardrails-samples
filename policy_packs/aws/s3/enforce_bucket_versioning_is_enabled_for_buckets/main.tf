resource "turbot_policy_pack" "main" {
  title       = "Enforce Bucket Versioning Is Enabled for AWS S3 Buckets"
  description = "This measure ensures data integrity, facilitates disaster recovery, and supports compliance with data retention policies by maintaining multiple versions of objects, enabling recovery in case of accidental deletions or overwrites."
  akas        = ["aws_s3_enforce_bucket_versioning_is_enabled_for_buckets"]
}
