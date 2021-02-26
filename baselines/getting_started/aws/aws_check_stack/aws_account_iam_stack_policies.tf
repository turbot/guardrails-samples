# AWS > Account > Stack
# https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/accountStack
resource "turbot_policy_setting" "aws_account_iam_stack" {
  count    = var.aws_account_iam_stack ? 1 : 0
  resource = turbot_smart_folder.aws_stack.id
  type     = "tmod:@turbot/aws#/policy/types/accountStack"
  value    = "Check: Configured"
  #value    = "Enforce: Configured"
}

# AWS > Account > Stack > Terraform Version
# https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/accountStackTerraformVersion
resource "turbot_policy_setting" "aws_account_iam_stack_tfversion" {
  count    = var.aws_account_iam_stack_tfversion ? 1 : 0
  resource = turbot_smart_folder.aws_stack.id
  type     = "tmod:@turbot/aws#/policy/types/accountStackTerraformVersion"
  value    = "0.13.*"
}

# AWS > Account > Stack > Source
# https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/accountStackSource
resource "turbot_policy_setting" "aws_account_iam_stack_source" {
  count    = var.aws_account_iam_stack_source ? 1 : 0
  resource = turbot_smart_folder.aws_stack.id
  type     = "tmod:@turbot/aws#/policy/types/accountStackSource"
  value    = <<-SOURCE
    ${file("./tf_includes/sourcestack_policies.tf")}
    SOURCE
}

# AWS > Turbot > Permissions > Custom Levels [Account]
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/permissionsCustomLevelsAccount
resource "turbot_policy_setting" "aws_iam_permissions_custom_levels_account" {
  count    = var.aws_iam_permissions_custom_levels_account ? 1 : 0
  resource = turbot_smart_folder.aws_stack.id
  type     = "tmod:@turbot/aws-iam#/policy/types/permissionsCustomLevelsAccount"
  value    = <<EOT
- example-role
EOT
}
