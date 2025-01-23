# GitHub > Repository > Forking > Enabled
resource "turbot_policy_setting" "github_repository_forking_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/repositoryForkingEnabled"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
