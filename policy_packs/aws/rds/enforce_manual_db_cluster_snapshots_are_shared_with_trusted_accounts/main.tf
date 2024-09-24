resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS RDS Manual DB Cluster Snapshots Are Shared With Trusted Accounts"
  description = "Ensure that sensitive data within snapshots is accessible only to authorized accounts, reducing the risk of unauthorized access and data breaches."
  akas        = ["aws_rds_enforce_manual_db_cluster_snapshots_are_shared_with_trusted_accounts"]
}
