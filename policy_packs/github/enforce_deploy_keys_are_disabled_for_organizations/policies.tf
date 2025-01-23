# GitHub > Organization > Deploy Keys > Enabled
resource "turbot_policy_setting" "github_organization_deploy_keys_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/organizationDeployKeysEnabled"
  value    = "Check: Disabled"
  # value    = "Enforce: Disabled"
}
