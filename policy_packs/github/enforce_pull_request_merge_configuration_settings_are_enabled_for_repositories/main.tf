resource "turbot_policy_pack" "main" {
  title       = "Enforce Pull Request Merge Configuration Settings Are Enabled for GitHub Repositories"
  description = "Enforcing pull request merge configuration settings for repositories ensures code quality and security by requiring thorough reviews and adherence to predefined standards before merging."
  akas        = ["github_enforce_pull_request_merge_configuration_settings_are_enabled_for_repositories"]
}
