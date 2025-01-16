resource "turbot_policy_pack" "main" {
  title       = "Enforce Delete Branch On Merge is Disabled for GitHub Repositories"
  description = "Enforcing branch deletion upon merge in GitHub repositories helps maintain a clean and organized repository structure by preventing unused branches from accumulating."
  akas        = ["github_enforce_delete_branch_on_merge_is_disabled_for_repositories"]
}
