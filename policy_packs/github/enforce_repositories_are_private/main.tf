resource "turbot_policy_pack" "main" {
  title       = "Enforce GitHub Repositories Are Private"
  description = "This practice restricts users from creating or maintaining public repositories, thereby enhancing the security of the codebase and protecting sensitive information from unauthorized access."
  akas        = ["github_enforce_repositories_are_private"]
}
