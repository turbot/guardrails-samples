## Set policy to deploy example GCP Project Stack
resource "turbot_policy_setting" "gcp_project_pubsub_stack" {
  resource = turbot_smart_folder.gcp_stack.id
  type     = "tmod:@turbot/gcp#/policy/types/projectStack"
  value    = "Check: Configured"
  #value    = "Enforce: Configured"
}

# Sets the Terraform version for your Source
resource "turbot_policy_setting" "gcp_project_pubsub_stack_tfversion" {
  resource = turbot_smart_folder.gcp_stack.id
  type     = "tmod:@turbot/gcp#/policy/types/projectStackTerraformVersion"
  value    = "0.12.*"
}

## Set policy to apply the Stack Source policy, the TF file source
resource "turbot_policy_setting" "gcp_project_pubsub_stack_source" {
  resource       = turbot_smart_folder.gcp_stack.id
  type           = "tmod:@turbot/gcp#/policy/types/projectStackSource"
  value           = <<-SOURCE
    ${file("./tf_includes/sourcestack.tf")}
    SOURCE
}