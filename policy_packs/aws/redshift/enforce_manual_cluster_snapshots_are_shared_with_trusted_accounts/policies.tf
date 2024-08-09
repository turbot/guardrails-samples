# AWS > Redshift > Manual Cluster Snapshot > Trusted Access
resource "turbot_policy_setting" "aws_redshift_manual_cluster_snapshot_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-redshift#/policy/types/clusterSnapshotManualTrustedAccess"
  value    = "Check: Trusted Access > Accounts"
  # value    = "Enforce: Trusted Access > Accounts"
}

# AWS > Redshift > Manual Cluster Snapshot > Trusted Access > Accounts
resource "turbot_policy_setting" "aws_redshift_manual_cluster_snapshot_trusted_access_accounts" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-redshift#/policy/types/clusterSnapshotManualTrustedAccessAccounts"
  value    = <<-EOT
    - "123456789012"
    - "123456789013"
    EOT
}
