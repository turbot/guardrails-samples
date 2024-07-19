# AWS > IAM > Role > Policy > Trusted Access
resource "turbot_policy_setting" "aws_iam_role_policy_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/rolePolicyTrustedAccess"
  value    = "Check: Trusted Access"
  # value    = "Enforce: Revoke untrusted access"
}

# AWS > IAM > Role > Policy > Trusted Access > Accounts
resource "turbot_policy_setting" "aws_iam_role_policy_trusted_accounts" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/rolePolicyTrustedAccounts"
  value    = <<-EOT
    - "123456789012"
    - "123456789013"
    EOT
}

# AWS > IAM > Role > Policy > Trusted Access > Services
resource "turbot_policy_setting" "aws_iam_role_policy_trusted_services" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/rolePolicyTrustedServices"
  value    = <<-EOT
    - "sns.amazonaws.com"
    - "ec2.amazonaws.com"
    EOT
}

# AWS > IAM > Role > Policy > Trusted Access > Identity Providers
resource "turbot_policy_setting" "aws_iam_role_policy_trusted_identity_providers" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/rolePolicyTrustedIdentityProviders"
  value    = <<-EOT
    - "www.acme.com"
    - "www.example.com"
    EOT
}

# AWS > IAM > Role > Policy > Trusted Access > Organization Restrictions
resource "turbot_policy_setting" "aws_iam_role_policy_trusted_organizations" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/rolePolicyTrustedOrganizations"
  value    = <<-EOT
    - "o-333333333"
    - "o-333333444"
    EOT
}
