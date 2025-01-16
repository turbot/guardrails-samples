# GitHub > Repository > Dependabot > Alerts
resource "turbot_policy_setting" "github_repository_dependabot_alerts" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/repositoryDependabotAlerts"
  value    = "Check: Disabled"
  # value    = "Enforce: Disabled"
}
