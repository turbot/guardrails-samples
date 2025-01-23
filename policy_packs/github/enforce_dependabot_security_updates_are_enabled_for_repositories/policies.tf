# GitHub > Repository > Dependabot > Security Updates
resource "turbot_policy_setting" "github_repository_dependabot_security_updates" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/repositoryDependabotSecurityUpdates"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
