resource "turbot_policy_pack" "main" {
  title       = "Enforce Forking Is Enabled for GitHub Repositories"
  description = "This practice allows users to create a copy of a repository under their own account, enabling independent development, experimentation, or collaboration without directly affecting the original repository."
  akas        = ["github_enforce_forking_is_enabled_for_repositories"]
}
