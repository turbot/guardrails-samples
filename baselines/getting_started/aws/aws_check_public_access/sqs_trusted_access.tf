# Restrict Public and Cross Account SQS Queues
# Assumes the default set of Trusted Accounts already set in this baseline.
# Commented out since these services are not associated to the initial mod install list

# Check on cross access SQS Queues

# resource "turbot_policy_setting" "aws_sqs_queue_trusted_access" {
#     resource        = turbot_smart_folder.aws_public_access.id
#     type            = "tmod:@turbot/aws-sqs#/policy/types/queuePolicyTrustedAccess"
#     value           = "Check: Trusted Access"
#     #value           = "Enforce: Revoke untrusted access"
# }

# ## tmod:@turbot/aws-sqs#/policy/types/queuePolicyTrustedAccounts already inherits from:
# ## tmod:@turbot/aws-sqs#/policy/types/sqsPolicyTrustedAccounts already inherits from:
# ## tmod:@turbot/aws#/policy/types/trustedAccounts is the global list set in this baseline

# ## Note: SQS Trusted Access also accepts default Organization Restrictions, Identity Providers and Services 