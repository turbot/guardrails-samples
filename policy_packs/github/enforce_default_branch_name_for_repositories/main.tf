resource "turbot_policy_pack" "main" {
  title       = "Enforce Default Branch Name for GitHub Repositories"
  description = "Enforcing a default branch name for GitHub repositories ensures consistency, improves workflow organization, and aligns with best practices for collaboration and version control."
  akas        = ["github_enforce_default_branch_name_for_repositories"]
}
