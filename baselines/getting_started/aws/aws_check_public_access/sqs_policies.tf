# Restrict Public and Cross Account SQS Queues
# Assumes the default set of Trusted Accounts already set in this baseline.

# AWS > SQS > Queue > Policy > Trusted Access
# https://turbot.com/v5/mods/turbot/aws-sqs/inspect#/policy/types/queuePolicyTrustedAccess
resource "turbot_policy_setting" "aws_sqs_queue_trusted_access" {
  count    = var.enable_aws_sqs_queue_trusted_access ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-sqs#/policy/types/queuePolicyTrustedAccess"
  value    = "Check: Trusted Access"
  #value   = "Enforce: Revoke untrusted access"
}

## tmod:@turbot/aws-sqs#/policy/types/queuePolicyTrustedAccounts already inherits from:
## tmod:@turbot/aws-sqs#/policy/types/sqsPolicyTrustedAccounts already inherits from:
## tmod:@turbot/aws#/policy/types/trustedAccounts is the global list set in this baseline

## Note: SQS Trusted Access also accepts default Organization Restrictions, Identity Providers and Services
