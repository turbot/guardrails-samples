resource "turbot_policy_pack" "main" {
  title       = "Enforce Discussions Are Enabled for GitHub Repositories"
  description = "This practice provides a collaborative space where team members and contributors can engage in open conversations, ask questions, share ideas, and provide feedback related to the project."
  akas        = ["github_enforce_discussions_are_enabled_for_repositories"]
}
