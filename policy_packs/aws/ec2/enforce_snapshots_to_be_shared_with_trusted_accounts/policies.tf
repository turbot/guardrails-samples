# AWS > EC2 > Snapshot > Trusted Access
resource "turbot_policy_setting" "aws_ec2_snapshot_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/snapshotTrustedAccess"
  value    = "Check: Trusted Access > Accounts"
  # value    = "Enforce: Trusted Access > Accounts"
}

# AWS > EC2 > Snapshot > Trusted Access > Accounts
resource "turbot_policy_setting" "aws_ec2_snapshot_trusted_access_accounts" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/snapshotTrustedAccessAccounts"
  value    = <<-EOT
    - "123456789012"
    - "123456789013"
  EOT
}
