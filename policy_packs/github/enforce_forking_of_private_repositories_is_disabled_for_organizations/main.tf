resource "turbot_policy_pack" "main" {
  title       = "Enforce Forking of Private Repositories is Disabled for GitHub Organizations"
  description = "Disabling of member privileges forking for private repositories in GitHub organizations is essential to prevent unauthorized sharing or exposure of sensitive code and intellectual property."
  akas        = ["github_enforce_forking_of_private_repositories_is_disabled_for_organizations"]
}
