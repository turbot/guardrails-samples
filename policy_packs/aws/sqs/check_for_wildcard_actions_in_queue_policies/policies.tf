# AWS > SQS > Queue > Approved
resource "turbot_policy_setting" "aws_sqs_queue_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-sqs#/policy/types/queueApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > SQS > Queue > Approved > Custom
resource "turbot_policy_setting" "aws_sqs_queue_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-sqs#/policy/types/queueApprovedCustom"
  template_input = <<-EOT
    {
      resource {
        policy: get(path: "Policy")
      }
    }
    EOT
  template       = <<-EOT
    {%- set regExp = r/"SQS:*/g -%}

    {%- if regExp.test($.resource.policy) -%}

      Not approved

    {%- else -%}

      Approved

    {%- endif -%}
  EOT
}
