# Azure > Search Management > Search Service > Public Network Access
resource "turbot_policy_setting" "azure_searchmanagement_search_service_public_network_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-searchmanagement#/policy/types/searchServicePublicNetworkAccess"
  value    = "Check: Disabled"
  # value    = "Check: Enabled"
  # value    = "Enforce: Disabled"
  # value    = "Enforce: Enabled"
}
