resource "turbot_policy_pack" "main" {
  title       = "Enforce Approved Replication Accounts for AWS S3 Buckets"
  description = "Ensure that only trusted and authorized accounts are used for replicating data, reducing the risk of unauthorized data access or replication."
  akas        = ["aws_s3_enforce_approved_replication_accounts_for_buckets"]
}
