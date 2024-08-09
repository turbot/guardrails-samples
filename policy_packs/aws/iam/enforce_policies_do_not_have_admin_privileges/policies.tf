# AWS > IAM > Policy > Statements > Approved
resource "turbot_policy_setting" "aws_iam_policy_statements_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/statementsApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete Unapproved"
}

# AWS > IAM > Policy > Statements > Approved > Administrator Access
resource "turbot_policy_setting" "aws_iam_policy_statements_approved_admin_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/statementsApprovedAdminAccess"
  value    = "Disabled: Disallow Administrator Access ('*:*') policies"
}
