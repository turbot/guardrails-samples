# Smart Folder Definition
resource "turbot_smart_folder" "lambda_vpc_check" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > Lambda > Function > Approved
resource "turbot_policy_setting" "aws_lambda_function_approved" {
  resource = turbot_smart_folder.lambda_vpc_check.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/functionApproved"
  value    = "Check: Approved"
}

# AWS > Lambda > Function > Approved > Usage
resource "turbot_policy_setting" "lambda_in_vpc" {
  resource = turbot_smart_folder.lambda_vpc_check.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/functionApprovedUsage"
  # GraphQL to get VPC config info
  template_input = <<EOT
{
    resource {
      vpc: get(path: "Configuration.VpcConfig")
    }
}
  EOT
  # Nunjucks Template Nunjucks Comments are formatted: {# comment #}
  template = <<EOT
{% if $.resource.vpc.VpcId %}
  "Approved"
{% else %}
  "Not Approved"
{% endif %}
  EOT
}
