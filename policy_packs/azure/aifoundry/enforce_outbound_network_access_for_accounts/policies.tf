# Azure > AI Foundry > Account > Outbound Network Access
resource "turbot_policy_setting" "azure_aifoundry_account_outbound_network_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-aifoundry#/policy/types/accountOutboundNetworkAccess"
  value    = "Check: Allow outbound per `Outbound Network Access > Allowed FQDNs`"
  # value    = "Check: Allow all outbound network access"
  # value    = "Enforce: Allow outbound per `Outbound Network Access > Allowed FQDNs`"
  # value    = "Enforce: Allow all outbound network access"
}

# Azure > AI Foundry > Account > Outbound Network Access > Allowed FQDNs
resource "turbot_policy_setting" "azure_aifoundry_account_outbound_network_access_allowed_fqdns" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-aifoundry#/policy/types/accountOutboundNetworkAccessAllowedFqdns"
  value    = []
  # Add the FQDNs the account is allowed to reach, for example:
  # value    = <<-EOT
  #   - "*.openai.azure.com"
  #   EOT
}
