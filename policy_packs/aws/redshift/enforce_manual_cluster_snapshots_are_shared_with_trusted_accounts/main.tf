resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS Redshift Manual Cluster Snapshots Are Shared With Trusted Accounts"
  description = "Ensure that sensitive data within snapshots is accessible only to authorized accounts, reducing the risk of unauthorized access and data breaches."
  akas        = ["aws_redshift_enforce_manual_cluster_snapshots_are_shared_with_trusted_accounts"]
}
