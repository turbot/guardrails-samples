# Azure > Application Gateway Service > Application Gateway > Approved > Usage
# https://turbot.com/v5/mods/turbot/azure-applicationgateway/inspect#/policy/types/applicationGatewayApprovedUsage
resource "turbot_policy_setting" "azure_applicationgateway_application_gateway_approved_usage" {
  count          = var.enable_application_gateway_approved_policies ? 1 : 0
  resource       = turbot_smart_folder.azure_public_access.id
  type           = "tmod:@turbot/azure-applicationgateway#/policy/types/applicationGatewayApprovedUsage"
  template_input = <<EOT
  {
    applicationGateway{
      frontendIPConfigurations
    }
  }
  EOT
  template       = <<EOT
  {%- set result = "Approved" -%}
  {%- set regExp = r/Succeeded/i -%}
  {%- if regExp.test($.applicationGateway.frontendIPConfigurations[0].provisioningState) -%}
    {%- set result = "Not approved" -%}
  {%- endif -%}

  {{ result }}
  EOT
}
