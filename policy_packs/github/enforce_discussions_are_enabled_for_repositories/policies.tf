# GitHub > Repository > Discussions > Enabled
resource "turbot_policy_setting" "github_repository_discussion_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/repositoryDiscussionsEnabled"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
