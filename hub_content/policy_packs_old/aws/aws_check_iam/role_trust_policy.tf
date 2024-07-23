# IAM Roles trusted only to Trusted Accounts defined in Public Access Baseline
# AWS > IAM > Role > Policy > Trusted Access
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/rolePolicyTrustedAccess
resource "turbot_policy_setting" "iam_role_policy_trusted_access" {
  count    = var.enable_iam_role_policy_trusted_access ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/rolePolicyTrustedAccess"
  value    = "Check: Trusted Access"
  ## "Enforce: Revoke untrusted access"
}

# ## Already Set globally in the Public Access Smart Folder Baseline, commenting out incase needed to enable here
# #List of Trusted Accounts for cross-account roles
# AWS > IAM > Role > Policy > Trusted Access > Accounts
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/rolePolicyTrustedAccounts
resource "turbot_policy_setting" "iam_role_trusted_accounts" {
  count    = var.enable_iam_role_trusted_accounts ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/rolePolicyTrustedAccounts"
  # GraphQL to pull current account info and list other accounts
  template_input = <<-QUERY
	{
		account{
			Id
			}
	}
QUERY

  # set trustedAccounts from terraform.tfvars
  template = <<-TEMPLATE
    ${yamlencode([for account in var.trusted_accounts : account])}
  TEMPLATE
}

# AWS > IAM > Role > Trust Relationship Statements [Deprecated] > Approved [Deprecated] > Rules [Deprecated]
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/trustRelationshipStatementsApprovedRules
# resource "turbot_policy_setting" "iam_role_trusted_accounts_rules" {
#   count     = var.enable_iam_role_trusted_accounts_rules ? 1 : 0
#   resource  = turbot_smart_folder.aws_iam.id
#   type      = "tmod:@turbot/aws-iam#/policy/types/trustRelationshipStatementsApprovedRules"
#   value     = <<-VALUE
#     APPROVE $.AssumeRolePolicyDocument.Statement.*.Action:null
#     APPROVE !$.AssumeRolePolicyDocument.Statement.*.Condition.StringEquals.'sts:ExternalId':null
#     REJECT *
# VALUE
# }



# Removing from standard baseline to simplify just for trusted access
# OCL Rules for approval
# List of Trusted Accounts for cross-account roles
#   Stmt 1: APPROVE Trust Relationships without STS Assume Role
#   Stmt 2: APPROVE Trust Relationships with STS AND External ID
#   Stmt 3: REJECT all others



