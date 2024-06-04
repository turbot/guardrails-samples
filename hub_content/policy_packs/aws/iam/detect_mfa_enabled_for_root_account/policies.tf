# AWS > IAM > Account Summary > Approved
resource "turbot_policy_setting" "aws_iam_account_summary_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountSummaryApproved"
  value    =  "Check: Approved"
}

# AWS > IAM > Account Summary > Approved > Custom
resource "turbot_policy_setting" "aws_iam_account_summary_approved_custom" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountSummaryApprovedCustom"
  template_input = <<-EOT
    {
      accountSummary {
        AccountMFAEnabled: get(path:"AccountMFAEnabled")
      }
    }
    EOT
  template       = <<-EOT
    {% if $.accountSummary.AccountMFAEnabled %}
    result: Approved
    message: "MFA is enabled on root account"
    {% else -%}
    result: Not approved
    message: "MFA is not enabled on root account"
    {% endif %}
    EOT
}