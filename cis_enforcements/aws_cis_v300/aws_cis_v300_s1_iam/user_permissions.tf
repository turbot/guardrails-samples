## AWS > IAM > User > Policy Attachments > Approved
resource "turbot_policy_setting" "aws_iam_user_policy_attachments_approved" {
  note     = <<-EOT
    AWS CIS v3.0.0 - Section 1 - IAM: |
      1.15 Ensure IAM Users Receive Permissions Only Through Groups. 
    EOT
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userPolicyAttachmentsApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

## AWS > IAM > User > Policy Attachments > Approved > Rules
resource "turbot_policy_setting" "aws_iam_user_policy_attachments_approved_rules" {
  note     = <<-EOT
    AWS CIS v3.0.0 - Section 1 - IAM: |
      1.15 Ensure IAM Users Receive Permissions Only Through Groups. 
    EOT
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userPolicyAttachmentsApprovedRules"
  value    = "REJECT *"
}

## AWS > IAM > User > Inline Policy > Approved
resource "turbot_policy_setting" "aws_iam_user_inline_policy_approved" {
  note     = <<-EOT
    AWS CIS v3.0.0 - Section 1 - IAM: |
      1.15 Ensure IAM Users Receive Permissions Only Through Groups. 
    EOT
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userInlinePolicyApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
  # value    = "Enforce: Delete unapproved if new"
}

## AWS > IAM > User > Inline Policy > Approved > Usage
resource "turbot_policy_setting" "aws_iam_user_inline_policy_approved_usage" {
  note     = <<-EOT
    AWS CIS v3.0.0 - Section 1 - IAM: |
      1.15 Ensure IAM Users Receive Permissions Only Through Groups. 
    EOT
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userInlinePolicyApprovedUsage"
  value    = "Not approved"
}



