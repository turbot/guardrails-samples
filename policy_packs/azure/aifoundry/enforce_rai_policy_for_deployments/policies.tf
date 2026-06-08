# Azure > AI Foundry > Deployment > RAI Policy
resource "turbot_policy_setting" "azure_aifoundry_deployment_rai_policy" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-aifoundry#/policy/types/deploymentRaiPolicy"
  value    = "Check: per `RAI Policy > Name`"
  # value    = "Enforce: per `RAI Policy > Name`"
}

# Azure > AI Foundry > Deployment > RAI Policy > Name
resource "turbot_policy_setting" "azure_aifoundry_deployment_rai_policy_name" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-aifoundry#/policy/types/deploymentRaiPolicyName"
  value    = "Microsoft.DefaultV2"
}
