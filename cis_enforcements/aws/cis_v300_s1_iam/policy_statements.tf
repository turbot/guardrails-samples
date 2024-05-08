# AWS > IAM > Policy > Statements > Approved
resource "turbot_policy_setting" "aws_iam_statements_approved" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/statementsApproved"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = "Check: Approved"
  # value    = "Enforce: Delete Unapproved"
}

# AWS > IAM > Policy > Statements > Approved > Rules
resource "turbot_policy_setting" "aws_iam_statements_approved_rules" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/statementsApprovedRules"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = <<-EOT
    REJECT $.Effect:"Allow" $.Action:"*"  $.Resource:"*"
    APPROVE *
    EOT
}

# AWS > IAM > Group > Inline Policy > Statements > Approved
resource "turbot_policy_setting" "aws_iam_group_inline_policy_statements_approved" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/groupInlinePolicyStatementsApproved"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = "Check: Approved"
  # value    = "Enforce: Delete Unapproved"
}

# AWS > IAM > Group > Inline Policy > Statements > Approved > Admin Access
resource "turbot_policy_setting" "aws_iam_group_inline_policy_statements_approved_admin_access" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/groupInlinePolicyStatementsApprovedAdminAccess"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = "Disabled: Disallow Administrator Access ('*:*') policies" 
}

# AWS > IAM > User > Inline Policy > Statements > Approved
resource "turbot_policy_setting" "aws_iam_user_inline_policy_statements_approved" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userInlinePolicyStatementsApproved"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = "Check: Approved"
  # value    = "Enforce: Delete Unapproved"
}

# AWS > IAM > User > Inline Policy > Statements > Approved > Admin Access
resource "turbot_policy_setting" "aws_iam_user_inline_policy_statements_approved_admin_access" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userInlinePolicyStatementsApprovedAdminAccess"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = "Disabled: Disallow Administrator Access ('*:*') policies"
}

# AWS > IAM > Role > Inline Policy > Statements > Approved
resource "turbot_policy_setting" "aws_iam_role_inline_policy_statements_approved" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/roleInlinePolicyStatementsApproved"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = "Check: Approved"
  # value    = "Enforce: Delete Unapproved"
}

# AWS > IAM > Role > Inline Policy > Statements > Approved > Admin Access
resource "turbot_policy_setting" "aws_iam_role_inline_policy_statements_approved_admin_access" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/roleInlinePolicyStatementsApprovedAdminAccess"
  note     = "AWS CIS v3.0.0 - Controls: 1.16"
  value    = "Disabled: Disallow Administrator Access ('*:*') policies"
}
