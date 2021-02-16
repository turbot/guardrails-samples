# Trusted Access Guardrails - https://turbot.com/v5/docs/concepts/guardrails/trusted-access

# Restrict Public and Cross Account SNS Topics
# Assumes the default set of Trusted Accounts already set in this baseline.

# AWS > SNS > Topic > Policy > Trusted Access
# https://turbot.com/v5/mods/turbot/aws-sns/inspect#/policy/types/topicPolicyTrustedAccess
resource "turbot_policy_setting" "aws_sns_topic_trusted_access" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-sns#/policy/types/topicPolicyTrustedAccess"
  value    = "Check: Trusted Access"
  #value  = "Enforce: Revoke untrusted access"
}

## tmod:@turbot/aws-sns#/policy/types/topicPolicyTrustedAccounts already inherits from:
## tmod:@turbot/aws-sns#/policy/types/snsPolicyTrustedAccounts already inherits from:
## tmod:@turbot/aws#/policy/types/trustedAccounts is the global list set in this baseline

## Note: SNS Trusted Access also accepts default Organization Restrictions, Identity Providers, and Services
