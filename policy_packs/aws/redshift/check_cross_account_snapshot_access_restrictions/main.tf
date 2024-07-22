resource "turbot_policy_pack" "main" {
  title       = "Check Cross-Account Snapshot Access Restrictions for Redshift Clusters"
  description = "Ensure that cross-account access to Redshift snapshots is restricted to enhance security and control over data."
  akas        = ["aws_redshift_check_cross_account_snapshot_access_restrictions"]
}