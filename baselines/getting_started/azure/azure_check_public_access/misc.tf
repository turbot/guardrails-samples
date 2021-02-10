## Azure Network Public IP
resource "turbot_policy_setting" "azure_network_public_ip_address_approved_usage" {
  resource = turbot_smart_folder.azure_public_access.id
  type     = "tmod:@turbot/azure-network#/policy/types/publicIpAddressApprovedUsage"
  value    = "Not approved"
}

## Azure Application Gateway Public IP
resource "turbot_policy_setting" "azure_applicationgateway_application_gateway_approved_usage" {
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
{% set regExp = r/Succeeded/i %}
{%- if regExp.test($.applicationGateway.frontendIPConfigurations[0].provisioningState) -%}
"Not approved"
{%- else -%}
"Approved"
{%- endif -%}
EOT
}

## Azure Storage Account Blob Public Access
resource "turbot_policy_setting" "azure_storage_account_public_access" {
  resource = turbot_smart_folder.azure_public_access.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountPublicAccess"
  value    = "Check: Enabled"
}

## Azure Storage Container Public Access Level
resource "turbot_policy_setting" "azure_storage_container_public_access" {
  resource = turbot_smart_folder.azure_public_access.id
  type     = "tmod:@turbot/azure-storage#/policy/types/containerPublicAccessLevel"
  value    = "Check: Private (No anonymous access)"
              # "Check: Blob (Anonymous read access for blobs only)"
              # "Check: Container (Anonymous read access for containers and blobs)"
              # "Check: Private (No anonymous access)"
}
