# GitHub > Repository > Code Security > Push Protection
resource "turbot_policy_setting" "github_repository_code_security_push_protection" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/repositoryCodeSecurityPushProtection"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
