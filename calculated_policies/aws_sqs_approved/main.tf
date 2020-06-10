# Smart Folder Definition
resource "turbot_smart_folder" "sqs_usage_approved" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > Region > Bucket > Approved
resource "turbot_policy_setting" "sqs_approved" {
  resource = turbot_smart_folder.sqs_usage_approved.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApproved"
  value    = "Check: Approved"
}

# AWS > Region > Bucket > Approved > Usage
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

# Attach Smart Folder
resource "turbot_smart_folder_attachment" "sqs_usage_approved_smart_folder_attachment" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.sqs_usage_approved.id
}
