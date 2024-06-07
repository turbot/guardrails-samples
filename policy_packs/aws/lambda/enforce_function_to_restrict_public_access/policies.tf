# AWS > Lambda > Function > Policy > Trusted Access
resource "turbot_policy_setting" "aws_lambda_function_policy_trusted_access" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/functionPolicyTrustedAccess"
  value    = "Check: Trusted Access"
  # value  = "Enforce: Revoke untrusted access"
}

# AWS > Lambda > Function > Policy > Trusted Access > Accounts
resource "turbot_policy_setting" "aws_lambda_function_policy_trusted_access_accounts" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/functionPolicyTrustedAccounts"
  # Insert your Account IDs below
  value = yamlencode(["123456789012", "123456789013"])
}

# AWS > Lambda > Function > Policy > Trusted Access > Services
resource "turbot_policy_setting" "aws_lambda_function_policy_trusted_access_services" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/functionPolicyTrustedServices"
  # Insert your services below
  value = yamlencode(["sns.amazonaws.com", "ec2.amazonaws.com"])
}
