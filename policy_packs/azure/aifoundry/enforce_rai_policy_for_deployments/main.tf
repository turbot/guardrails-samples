resource "turbot_policy_pack" "main" {
  title       = "Enforce Responsible AI Policy for Azure AI Foundry Deployments"
  description = "Require Azure AI Foundry deployments to use an approved Responsible AI (RAI) content filtering policy."
  akas        = ["azure_aifoundry_enforce_rai_policy_for_deployments"]
}
