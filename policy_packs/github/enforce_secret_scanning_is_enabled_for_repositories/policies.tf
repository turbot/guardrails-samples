# GitHub > Repository > Code Security > Secret Scanning
resource "turbot_policy_setting" "github_repository_code_security_secret_scanning" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/repositoryCodeSecuritySecretScanning"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
