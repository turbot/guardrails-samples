resource "turbot_policy_pack" "main" {
  title       = "Enforce Approved Model Version for Azure AI Foundry Deployments"
  description = "Pin Azure AI Foundry deployments to an approved model version so that workloads run on a known, tested version of the model."
  akas        = ["azure_aifoundry_enforce_model_version_for_deployments"]
}
