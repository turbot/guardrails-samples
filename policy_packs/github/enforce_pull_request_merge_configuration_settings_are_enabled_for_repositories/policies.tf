# GitHub > Repository > Merge Configuration
resource "turbot_policy_setting" "github_repository_pull_request_merge_configuration" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/repositoryPullRequestMergeConfiguration"
  value    = "Check: Enabled per Merge Configuration > Settings"
  # value    = "Enforce: Enabled per Merge Configuration > Settings"
}

# GitHub > Repository > Merge Configuration > Settings
resource "turbot_policy_setting" "github_repository_pull_request_merge_configuration_settings" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/repositoryPullRequestMergeConfigurationSettings"
  value    = <<-EOT
    - "Merge Commit"
    - "Rebase Merge"
    - "Squash Merge"
  EOT
}
