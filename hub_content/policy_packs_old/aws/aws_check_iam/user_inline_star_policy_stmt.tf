# Check IAM User inline policy for AdministratorAccess
# AWS > IAM > User > Inline Policy > Statements > Approved
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/userInlinePolicyStatementsApproved

resource "turbot_policy_setting" "iam_user_inline_policy_approved" {
  count    = var.enable_iam_user_inline_policy_approved ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userInlinePolicyStatementsApproved"
  value    = "Check: Approved"
  ## "Enforce: Delete Unapproved"
}

# AWS > IAM > Role > Policy Attachments > Approved > Administrator Access
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/userInlinePolicyStatementsApprovedAdminAccess
resource "turbot_policy_setting" "iam_user_inline_policy_approved_admin_access" {
  count    = var.enable_iam_user_inline_policy_approved_admin_access ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userInlinePolicyStatementsApprovedAdminAccess"
  value    = <<EOT
	'Disabled: Disallow Administrator Access (''*:*'') policies'
EOT
  ## 'Enabled: Allow Administrator Access (''*:*'') policies'
}
