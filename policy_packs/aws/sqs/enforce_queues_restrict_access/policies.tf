# AWS > SQS > Queue > Policy > Trusted Access
resource "turbot_policy_setting" "aws_sqs_queue_policy_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-sqs#/policy/types/queuePolicyTrustedAccess"
  value    = "Check: Trusted Access"
  # value    = "Enforce: Revoke untrusted access"
}

# AWS > SQS > Queue > Policy > Trusted Access > Accounts
resource "turbot_policy_setting" "aws_sqs_queue_policy_trusted_access_accounts" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-sqs#/policy/types/queuePolicyTrustedAccounts"
  value    = <<-EOT
    - "123456789012"
    - "123456789013"
    EOT
}

# AWS > SQS > Queue > Policy > Trusted Access > Services
resource "turbot_policy_setting" "aws_sqs_queue_policy_trusted_access_services" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-sqs#/policy/types/queuePolicyTrustedServices"
  value    = <<-EOT
    - "sns.amazonaws.com"
    - "ec2.amazonaws.com"
    EOT
}

# AWS > SQS > Queue > Policy > Trusted Access > Organization Restrictions
resource "turbot_policy_setting" "aws_sqs_queue_policy_trusted_access_organizations" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-sqs#/policy/types/queuePolicyTrustedOrganizations"
  value    = <<-EOT
    - "o-a3333333333"
    - "o-c3a5y4wd45"
    EOT
}
