# AWS > IAM > User > Policy Attachments > Approved
resource "turbot_policy_setting" "aws_iam_user_policy_attachments_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userPolicyAttachmentsApproved"
  note     = "AWS CIS v3.0.0 - Controls: 1.15"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# AWS > IAM > User > Policy Attachments > Approved > Rules
resource "turbot_policy_setting" "aws_iam_user_policy_attachments_approved_rules" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userPolicyAttachmentsApprovedRules"
  note     = "AWS CIS v3.0.0 - Controls: 1.15"
  value    = "REJECT *"
}

# AWS > IAM > User > Inline Policy > Approved
resource "turbot_policy_setting" "aws_iam_user_inline_policy_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userInlinePolicyApproved"
  note     = "AWS CIS v3.0.0 - Controls: 1.15"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > IAM > User > Inline Policy > Approved > Usage
resource "turbot_policy_setting" "aws_iam_user_inline_policy_approved_usage" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userInlinePolicyApprovedUsage"
  note     = "AWS CIS v3.0.0 - Controls: 1.15"
  value    = "Not approved"
}
