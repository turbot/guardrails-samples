resource "turbot_policy_pack" "main" {
  title       = "Enforce Wikis Are Enabled for GitHub Repositories"
  description = "This practice allow repository collaborators to create and maintain documentation directly alongside the codebase, promoting better knowledge sharing and collaboration."
  akas        = ["github_enforce_wikis_are_enabled_for_repositories"]
}
