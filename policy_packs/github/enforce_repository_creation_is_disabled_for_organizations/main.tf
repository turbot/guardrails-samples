resource "turbot_policy_pack" "main" {
  title       = "Enforce Repository Creation is Disabled for GitHub Organizations"
  description = "Disabling member privileges repository creation for GitHub organizations ensures centralized control over resource management, preventing unauthorized or unmonitored repositories that could pose security risks."
  akas        = ["github_enforce_repository_creation_is_disabled_for_organizations"]
}
