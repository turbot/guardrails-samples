resource "turbot_policy_pack" "main" {
  title       = "Enforce Allowed Authentication Types for Azure AI Foundry Connections"
  description = "Restrict Azure AI Foundry connections to an approved set of authentication types so that only sanctioned credential methods are used."
  akas        = ["azure_aifoundry_enforce_allowed_auth_types_for_connections"]
}
