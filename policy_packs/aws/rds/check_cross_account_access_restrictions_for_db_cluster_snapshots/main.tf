resource "turbot_policy_pack" "main" {
  title       = "Check Cross-Account Access Restrictions for DB Cluster Snapshots"
  description = "Ensure that RDS DB cluster snapshots are not accessible across accounts to enhance security and control over data."
  akas        = ["aws_rds_check_cross_account_access_restrictions_for_db_cluster_snapshots"]
}
