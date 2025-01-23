resource "turbot_policy_pack" "main" {
  title       = "Enforce Deploy Keys Are Disabled for GitHub Organizations"
  description = "Disabling deploy keys for GitHub organizations is essential to ensure secure access management and prevent unauthorized repository access."
  akas        = ["github_enforce_deploy_keys_are_disabled_for_organizations"]
}
