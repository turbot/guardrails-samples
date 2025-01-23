resource "turbot_policy_pack" "main" {
  title       = "Enforce Push Protection Is Enabled for GitHub Repositories"
  description = "This practice scans for secrets, such as API keys, tokens, or other sensitive credentials, during the push process and blocks them from being pushed to the repository."
  akas        = ["github_enforce_push_protection_is_enabled_for_repositories"]
}
