# GitHub > Repository > Wikis > Enabled
resource "turbot_policy_setting" "github_repository_wikis_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/repositoryWikisEnabled"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
