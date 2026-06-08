resource "turbot_policy_pack" "main" {
  title       = "Enforce Allowed Model Names for Azure AI Foundry Deployments"
  description = "Restrict Azure AI Foundry deployments to an approved set of model names so that only sanctioned models are deployed."
  akas        = ["azure_aifoundry_enforce_allowed_model_names_for_deployments"]
}
