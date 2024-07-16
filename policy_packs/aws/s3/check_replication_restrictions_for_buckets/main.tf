resource "turbot_policy_pack" "main" {
  title       = "Check Replication Restrictions for Buckets"
  description = "Ensure that S3 buckets are not replicated to non-SF accounts for enhanced security and compliance."
  akas        = ["aws_s3_check_replication_restrictions_for_buckets"]
}
