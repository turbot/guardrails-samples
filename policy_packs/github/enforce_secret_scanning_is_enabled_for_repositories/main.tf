resource "turbot_policy_pack" "main" {
  title       = "Enforce Secret Scanning Is Enabled for GitHub Repositories"
  description = "This practice detects sensitive information, such as API keys, tokens, passwords, and other credentials, that may accidentally be committed to the repository."
  akas        = ["github_enforce_secret_scanning_is_enabled_for_repositories"]
}
