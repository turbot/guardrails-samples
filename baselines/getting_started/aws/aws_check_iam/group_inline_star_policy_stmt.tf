# Check IAM Group inline policy for AdministratorAccess

# AWS > IAM > Group > Inline Policy > Statements > Approved
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/groupInlinePolicyStatementsApproved
resource "turbot_policy_setting" "iam_group_inline_policy_approved" {
  resource        = turbot_smart_folder.aws_iam.id
  type            = "tmod:@turbot/aws-iam#/policy/types/groupInlinePolicyStatementsApproved"
  value           = "Check: Approved"
                    ## "Enforce: Delete Unapproved"
}

# AWS > IAM > Group > Inline Policy > Statements > Approved > Administrator Access
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/groupInlinePolicyStatementsApprovedAdminAccess
resource "turbot_policy_setting" "iam_group_inline_policy_approved_admin_access" {
  resource        = turbot_smart_folder.aws_iam.id
  type            = "tmod:@turbot/aws-iam#/policy/types/groupInlinePolicyStatementsApprovedAdminAccess"
  value    = <<EOT
	'Disabled: Disallow Administrator Access (''*:*'') policies'
EOT
## 'Enabled: Allow Administrator Access (''*:*'') policies'
}