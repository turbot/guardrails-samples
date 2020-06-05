resource "turbot_smart_folder" "sqs_usage_approved" {
  title       = var.smart_folder_title
  description = "Alarms if an SQS queue policy allows SQS:*"
  parent      = "tmod:@turbot/turbot#/"
}

resource "turbot_policy_setting" "sqs_approved" {
  resource = turbot_smart_folder.sqs_usage_approved.id
  type = "tmod:@turbot/aws-s3#/policy/types/bucketApproved"
  value = "Check: Approved"
}

resource "turbot_policy_setting" "sqs_usage_approved" {
  resource = turbot_smart_folder.sqs_usage_approved.id
  type     = "tmod:@turbot/aws-sqs#/policy/types/queueApprovedUsage"
  # GraphQL to pull bucket metadata
  template_input = <<EOT
  {
    resource {
      pol: get(path: "Policy")
    }
  }
  EOT
  # Nunjucks Template Nunjucks Comments are formatted: {# comment #}
  template = <<EOT
  {%- set regExp = r/"SQS:*/g -%}
  {%- if regExp.test($.resource.pol) -%}
    Not approved
  {%- else -%}
    Approved
  {%- endif -%}
  EOT
}

resource "turbot_smart_folder_attachment" "sqs_usage_approved_smart_folder_attachment" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.sqs_usage_approved.id
}
