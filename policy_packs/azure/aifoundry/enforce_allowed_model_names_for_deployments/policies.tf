# Azure > AI Foundry > Deployment > Allowed > Model Name
resource "turbot_policy_setting" "azure_aifoundry_deployment_allowed_model_name" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-aifoundry#/policy/types/deploymentAllowedModelName"
  value    = "Check: Allowed model name"
  # value    = "Enforce: Delete if model name not allowed"
  # value    = "Enforce: Delete if model name not allowed and resource is new"
}

# Azure > AI Foundry > Deployment > Allowed > Model Name > Names
resource "turbot_policy_setting" "azure_aifoundry_deployment_allowed_model_name_names" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-aifoundry#/policy/types/deploymentAllowedModelNameNames"
  value    = <<-EOT
    - "gpt-4o"
    - "gpt-4o-mini"
    EOT
}
