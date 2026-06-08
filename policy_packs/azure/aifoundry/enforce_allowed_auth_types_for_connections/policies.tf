# Azure > AI Foundry > Connection > Allowed > Auth Type
resource "turbot_policy_setting" "azure_aifoundry_connection_allowed_auth_type" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-aifoundry#/policy/types/connectionAllowedAuthType"
  value    = "Check: Allowed auth type"
  # value    = "Enforce: Delete if auth type not allowed"
  # value    = "Enforce: Delete if auth type not allowed and resource is new"
}

# Azure > AI Foundry > Connection > Allowed > Auth Type > Types
resource "turbot_policy_setting" "azure_aifoundry_connection_allowed_auth_type_types" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-aifoundry#/policy/types/connectionAllowedAuthTypeTypes"
  value    = <<-EOT
    - "ApiKey"
    - "ManagedIdentity"
    - "AAD"
    EOT
}
