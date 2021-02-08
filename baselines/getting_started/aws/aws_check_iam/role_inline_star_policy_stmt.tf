# Check IAM Role inline policy for AdministratorAccess

# AWS > IAM > Role > Inline Policy > Statements > Approved
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/roleInlinePolicyStatementsApproved
resource "turbot_policy_setting" "iam_role_inline_policy_approved" {
  count     = var.enable_iam_role_inline_policy_approved ? 1 : 0
  resource  = turbot_smart_folder.aws_iam.id
  type      = "tmod:@turbot/aws-iam#/policy/types/roleInlinePolicyStatementsApproved"
  value     = "Check: Approved"
           ## "Enforce: Delete Unapproved"
}

# AWS > IAM > Role > Inline Policy > Statements > Approved > Administrator Access
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/roleInlinePolicyStatementsApprovedAdminAccess
resource "turbot_policy_setting" "iam_role_inline_policy_approved_admin_access" {
  count    = var.enable_iam_role_inline_policy_approved_admin_access ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/roleInlinePolicyStatementsApprovedAdminAccess"
  value    = <<EOT
	'Disabled: Disallow Administrator Access (''*:*'') policies'
EOT
## 'Enabled: Allow Administrator Access (''*:*'') policies'
}