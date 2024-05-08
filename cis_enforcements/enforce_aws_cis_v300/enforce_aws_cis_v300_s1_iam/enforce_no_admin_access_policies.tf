resource "turbot_policy_setting" "aws_iam_group_inline_policy_statements_approved_admin_access" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/groupInlinePolicyStatementsApprovedAdminAccess"
  value    = "Disabled: Disallow Administrator Access ('*:*') policies"
  note     = "Forbids inline policies that grant AdminAccess"
}

resource "turbot_policy_setting" "aws_iam_user_inline_policy_statements_approved_admin_access" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userInlinePolicyStatementsApprovedAdminAccess"
  value    = "Disabled: Disallow Administrator Access ('*:*') policies"
  note     = "Forbids inline policies that grant AdminAccess"
}

resource "turbot_policy_setting" "aws_iam_role_inline_policy_statements_approved_admin_access" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/roleInlinePolicyStatementsApprovedAdminAccess"
  value    = "Disabled: Disallow Administrator Access ('*:*') policies"
  note     = "Forbids inline policies that grant AdminAccess"
}

# AWS > IAM > Policy > Statements > Approved
resource "turbot_policy_setting" "aws_iam_statements_approved" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/statementsApproved"
  value    = "Check: Approved"
  #value    = "Enforce: Delete Unapproved"
  note = "AWS CIS v3.0.0 - Controls: 1.16 -Ensure IAM policies that allow full \"*:*\" administrative privileges are not attached (Automated)"
}

# AWS > IAM > Policy > Statements > Approved > Rules
resource "turbot_policy_setting" "aws_iam_statements_approved_rules" {
resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/statementsApprovedRules"
  value    = <<EOT
REJECT $.Effect:"Allow" $.Action:"*"  $.Resource:"*"
APPROVE *
EOT
  note = "Matches on any IAM policy statement that has 'Allow Action:* on Resource:*'"
}