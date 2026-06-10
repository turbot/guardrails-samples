resource "turbot_policy_pack" "main" {
  title       = "Enforce Public Network Access Is Disabled for Azure Search Services"
  description = "Reduce the network attack surface of Azure AI Search (Search Management) search services by requiring public network access to be disabled so the service is only reachable through private endpoints."
  akas        = ["azure_searchmanagement_enforce_public_network_access_disabled_for_search_services"]
}
