# AWS > RDS > DB Cluster Snapshot [Manual] > Trusted Access
resource "turbot_policy_setting" "aws_rds_db_cluster_snapshot_manual_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbClusterSnapshotManualTrustedAccess"
  value    = "Check: Trusted Access > Accounts"
  # value    = "Enforce: Trusted Access > Accounts"
}

# AWS > RDS > DB Cluster Snapshot [Manual] > Trusted Access > Accounts
resource "turbot_policy_setting" "aws_rds_db_cluster_snapshot_manual_trusted_access_accounts" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbClusterSnapshotManualTrustedAccessAccounts"
  value    = <<-EOT
    - "123456789012"
    - "123456789013"
    EOT
}

