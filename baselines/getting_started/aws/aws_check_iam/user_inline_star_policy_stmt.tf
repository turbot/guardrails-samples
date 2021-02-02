# Check IAM User inline policy for AdministratorAccess

resource "turbot_policy_setting" "iam_user_inline_policy_approved" {
  resource        = turbot_smart_folder.aws_iam.id
  type            = "tmod:@turbot/aws-iam#/policy/types/userInlinePolicyStatementsApproved"
  value           = "Check: Approved"
                    ## "Enforce: Delete Unapproved"
}

resource "turbot_policy_setting" "iam_user_inline_policy_approved_admin_access" {
  resource        = turbot_smart_folder.aws_iam.id
  type            = "tmod:@turbot/aws-iam#/policy/types/userInlinePolicyStatementsApprovedAdminAccess"
  value    = <<EOT
	'Disabled: Disallow Administrator Access (''*:*'') policies'
EOT
## 'Enabled: Allow Administrator Access (''*:*'') policies'
}