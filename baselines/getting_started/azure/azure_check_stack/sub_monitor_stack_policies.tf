## Set policy to deploy example Azure Subscription Stack

# Azure > Subscription > Stack
# https://turbot.com/v5/mods/turbot/azure/inspect#/policy/types/subscriptionStack
resource "turbot_policy_setting" "azure_subscription_monitor_stack" {
  resource = turbot_smart_folder.azure_stack.id
  type     = "tmod:@turbot/azure#/policy/types/subscriptionStack"
  value    = "Check: Configured"
  #value    = "Enforce: Configured"
}

# Azure > Subscription > Stack > Terraform Version
# https://turbot.com/v5/mods/turbot/azure/inspect#/policy/types/subscriptionStackTerraformVersion
# Sets the Terraform version for your Source
resource "turbot_policy_setting" "azure_subscription_monitor_stack_tfversion" {
  resource = turbot_smart_folder.azure_stack.id
  type     = "tmod:@turbot/azure#/policy/types/subscriptionStackTerraformVersion"
  value    = "0.13.*"
}

# Azure > Subscription > Stack > Source
# https://turbot.com/v5/mods/turbot/azure/inspect#/policy/types/subscriptionStackSource
## Set policy to apply the Stack Source policy, the TF file source
resource "turbot_policy_setting" "azure_subscription_monitor_stack_source" {
  resource       = turbot_smart_folder.azure_stack.id
  type           = "tmod:@turbot/azure#/policy/types/subscriptionStackSource"
  value           = <<-SOURCE
    ${file("./tf_includes/sourcestack_policies.tf")}
    SOURCE
}