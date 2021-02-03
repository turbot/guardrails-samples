## Set policy to deploy example AWS Account IAM Stack
resource "turbot_policy_setting" "aws_account_iam_stack" {
  resource = turbot_smart_folder.aws_stack.id
  type     = "tmod:@turbot/aws#/policy/types/accountStack"
  value    = "Check: Configured"
  #value    = "Enforce: Configured"
}

# Sets the Terraform version for your Source
resource "turbot_policy_setting" "aws_account_iam_stack_tfversion" {
  resource = turbot_smart_folder.aws_stack.id
  type     = "tmod:@turbot/aws#/policy/types/accountStackTerraformVersion"
  value    = "0.12.*"
}

## Set policy to apply the Stack Source policy, the TF file source
resource "turbot_policy_setting" "aws_account_iam_stack_source" {
  resource       = turbot_smart_folder.aws_stack.id
  type           = "tmod:@turbot/aws#/policy/types/accountStackSource"
  value           = <<-SOURCE
    ${file("./tf_includes/sourcestack.tf")}
    SOURCE
}

# This is part of the Turbot RBAC use case if you are creating an IAM Role through Turbot
# And associating that as a custom role for Turbot to manage to grant time based access
# Can comment out if not using Turbot RBAC / AWS Permissions through Turbot.
# This just sets the condition in your environment, no changes will action unless using Turbot AWS RBAC
resource "turbot_policy_setting" "aws_iam_permissions_custom_levels_account" {
  resource = turbot_smart_folder.aws_stack.id
  type     = "tmod:@turbot/aws-iam#/policy/types/permissionsCustomLevelsAccount"
  value    = <<EOT
- example-role
EOT
}
