resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS RDS DB Cluster Manual Snapshots Are Shared With Approved Accounts"
  description = "Ensure that sensitive data within snapshots is accessible only to authorized accounts, reducing the risk of unauthorized access and data breaches."
  akas        = ["aws_rds_enforce_db_cluster_manual_snapshots_are_shared_with_approved_accounts"]
}
