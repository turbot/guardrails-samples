## Set policy to deploy example GCP Project Stack
# GCP > Project > Stack
# https://turbot.com/v5/mods/turbot/gcp/inspect#/policy/types/projectStack
resource "turbot_policy_setting" "gcp_project_pubsub_stack" {
  count    = var.gcp_project_pubsub_stack_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_stack.id
  type     = "tmod:@turbot/gcp#/policy/types/projectStack"
  value    = "Check: Configured"
  #value    = "Enforce: Configured"
}

# Sets the Terraform version for your Source
# GCP > Project > Stack > Terraform Version
# https://turbot.com/v5/mods/turbot/gcp/inspect#/policy/types/projectStackTerraformVersion
resource "turbot_policy_setting" "gcp_project_pubsub_stack_tfversion" {
  count    = var.gcp_project_pubsub_stack_tfversion_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_stack.id
  type     = "tmod:@turbot/gcp#/policy/types/projectStackTerraformVersion"
  value    = "0.12.*"
}

## Set policy to apply the Stack Source policy, the TF file source
# GCP > Project > Stack > Source
# https://turbot.com/v5/mods/turbot/gcp/inspect#/policy/types/projectStackSource
resource "turbot_policy_setting" "gcp_project_pubsub_stack_source" {
  count    = var.gcp_project_pubsub_stack_source_policies ? 1 : 0
  resource       = turbot_smart_folder.gcp_stack.id
  type           = "tmod:@turbot/gcp#/policy/types/projectStackSource"
  value           = <<-SOURCE
    ${file("./tf_includes/sourcestack_policies.tf")}
    SOURCE
}