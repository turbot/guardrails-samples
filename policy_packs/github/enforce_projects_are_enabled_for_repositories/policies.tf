# GitHub > Repository > Projects > Enabled
resource "turbot_policy_setting" "github_repository_projects_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/repositoryProjectsEnabled"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
