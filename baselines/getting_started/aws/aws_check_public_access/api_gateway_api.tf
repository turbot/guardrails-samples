# Check for Public API Gateway APIs
# Commented out since these services are not associated to the initial mod install list


# Check on public API Gateway APIs

# AWS > API Gateway > API > Approved
# https://turbot.com/v5/mods/turbot/aws-apigateway/inspect#/policy/types/apiApproved
resource "turbot_policy_setting" "aws_apigateway_api_approved" {
  count    = var.enable_aws_apigateway_api_approved ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-apigateway#/policy/types/apiApproved"
  value    = "Check: Approved"
}


# AWS > API Gateway > API > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-apigateway/inspect#/policy/types/apiApprovedUsage
resource "turbot_policy_setting" "aws_apigateway_api_approved_usage" {
  count          = var.enable_aws_apigateway_api_approved_usage ? 1 : 0
  resource       = turbot_smart_folder.aws_public_access.id
  type           = "tmod:@turbot/aws-apigateway#/policy/types/apiApprovedUsage"
  template_input = <<EOT
{
  api{
    endpointConfiguration
  }
}
EOT
  template       = <<EOT
{%- if $.api.endpointConfiguration.types == "PRIVATE" -%}
Approved
{%- else -%}
Not approved
{%- endif -%}
EOT
}
