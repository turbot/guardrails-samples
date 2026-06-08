# Azure > AI Foundry > Deployment > Model Version
resource "turbot_policy_setting" "azure_aifoundry_deployment_model_version" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-aifoundry#/policy/types/deploymentModelVersion"
  value    = "Check: per `Model Version > Required Version`"
  # value    = "Enforce: per `Model Version > Required Version`"
}

# Azure > AI Foundry > Deployment > Model Version > Required Version
resource "turbot_policy_setting" "azure_aifoundry_deployment_model_version_required_version" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-aifoundry#/policy/types/deploymentModelVersionRequiredVersion"
  value    = "2024-08-06"
}
