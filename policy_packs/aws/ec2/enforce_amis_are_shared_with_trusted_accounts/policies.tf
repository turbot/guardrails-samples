# AWS > EC2 > AMI > Trusted Access
resource "turbot_policy_setting" "aws_ec2_ami_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/amiTrustedAccess"
  value    = "Check: Trusted Access > Accounts"
  # value    = "Enforce: Trusted Access > Accounts"
}

# AWS > EC2 > AMI > Trusted Access > Accounts
resource "turbot_policy_setting" "aws_ec2_ami_trusted_access_accounts" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/amiTrustedAccessAccounts"
  value    = <<-EOT
    - "123456789012"
    - "123456789013"
  EOT
}
