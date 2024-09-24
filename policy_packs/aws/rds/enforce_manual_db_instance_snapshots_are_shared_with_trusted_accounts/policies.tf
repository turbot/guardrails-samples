# AWS > RDS > DB Snapshot [Manual] > Trusted Access
resource "turbot_policy_setting" "aws_rds_db_snapshot_manual_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbSnapshotManualTrustedAccess"
  value    = "Check: Trusted Access > Accounts"
  # value    = "Enforce: Trusted Access > Accounts"
}

# AWS > RDS > DB Snapshot [Manual] > Trusted Access > Accounts
resource "turbot_policy_setting" "aws_rds_db_snapshot_manual_trusted_access_accounts" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbSnapshotManualTrustedAccessAccounts"
  value    = <<-EOT
    - "123456789012"
    - "123456789013"
    EOT
}
