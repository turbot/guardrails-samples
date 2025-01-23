# GitHub > Repository > Visibility
resource "turbot_policy_setting" "github_repository_visibility" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/repositoryVisibility"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
