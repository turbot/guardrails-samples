# Smart Folder Definition
resource "turbot_smart_folder" "aws_lambda_not_approved_cross_account_access" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > Lambda > Function > Approved
resource "turbot_policy_setting" "aws_lambda_function_approved" {
  resource = turbot_smart_folder.aws_lambda_not_approved_cross_account_access.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/functionApproved"
  value    = "Check: Approved"
}

# AWS > Lambda > Function > Approved > Usage
resource "turbot_policy_setting" "aws_lambda_not_approved_cross_account_access" {
  resource = turbot_smart_folder.aws_lambda_not_approved_cross_account_access.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/functionApprovedUsage"
  # GraphQL to pull function metadata
  template_input = <<EOT
  {
    resource {
      iamPolicies: get(path: "IamPolicy.Policy.Statement")
      turbot {
        custom
      }
    }
  }
  EOT
  # Nunjucks Template Nunjucks Comments are formatted: {# comment #}
  template = <<EOT
  {% set has_cross_account = false -%}
  {% for iamPolicy in $.resource.iamPolicies -%}
  {%   if iamPolicy.Principal.AWS and iamPolicy.Principal.AWS.split(':')[4] != $.resource.turbot.custom.aws.accountId -%}
  {%     set has_cross_account = true -%}
  {%   endif -%}
  {%   if iamPolicy.Condition.StringEquals['AWS:SourceAccount'] and iamPolicy.Condition.StringEquals['AWS:SourceAccount'] != $.resource.turbot.custom.aws.accountId -%}
  {%     set has_cross_account = true -%}
  {%   endif -%}
  {%   if iamPolicy.Condition.ArnLike['AWS:SourceArn'] and iamPolicy.Condition.ArnLike['AWS:SourceArn'].split(':')[4] != $.resource.turbot.custom.aws.accountId -%}
  {%     set has_cross_account = true -%}
  {%   endif -%}
  {% endfor -%}
  {% if has_cross_account -%}
      "Not approved"
  {%- else -%}
      "Approved"
  {%- endif -%}
  EOT
}

# Attach Smart Folder
resource "turbot_smart_folder_attachment" "aws_lambda_not_approved_cross_account_access" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.aws_lambda_not_approved_cross_account_access.id
}
