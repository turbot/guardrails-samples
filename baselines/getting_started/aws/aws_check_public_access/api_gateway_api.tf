# Check for Public API Gateway APIs
# Commented out since these services are not associated to the initial mod install list


# Check on public API Gateway APIs
# resource "turbot_policy_setting" "aws_apigateway_api_approved" {
#   resource = turbot_smart_folder.aws_public_access.id
#   type     = "tmod:@turbot/aws-apigateway#/policy/types/apiApproved"
#   value    = "Check: Approved"
# }


# resource "turbot_policy_setting" "aws_apigateway_api_approved_usage" {
#   resource       = turbot_smart_folder.aws_public_access.id
#   type           = "tmod:@turbot/aws-apigateway#/policy/types/apiApprovedUsage"
#   template_input = <<EOT
# {
#   api{
#     endpointConfiguration
#   }
# }
# EOT
#   template       = <<EOT
# {%- if $.api.endpointConfiguration.types == "PRIVATE" -%}
# Approved
# {%- else -%}
# Not approved
# {%- endif -%}
# EOT
# }