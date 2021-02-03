## Set policy to deploy example Azure Subscription Stack
resource "turbot_policy_setting" "azure_subscription_monitor_stack" {
  resource = turbot_smart_folder.azure_stack.id
  type     = "tmod:@turbot/azure#/policy/types/subscriptionStack"
  value    = "Check: Configured"
  #value    = "Enforce: Configured"
}

# Sets the Terraform version for your Source
resource "turbot_policy_setting" "azure_subscription_monitor_stack_tfversion" {
  resource = turbot_smart_folder.azure_stack.id
  type     = "tmod:@turbot/azure#/policy/types/subscriptionStackTerraformVersion"
  value    = "0.12.*"
}

## Set policy to apply the Stack Source policy, the TF file source
resource "turbot_policy_setting" "azure_subscription_monitor_stack_source" {
  resource       = turbot_smart_folder.azure_stack.id
  type           = "tmod:@turbot/azure#/policy/types/subscriptionStackSource"
  value           = <<-SOURCE
    ${file("./tf_includes/sourcestack.tf")}
    SOURCE
}