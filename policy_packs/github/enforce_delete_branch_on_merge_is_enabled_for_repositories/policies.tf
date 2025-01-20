# GitHub > Repository > Pull Request > Delete Branch on Merge
resource "turbot_policy_setting" "github_repository_pull_request_delete_branch_on_merge" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/repositoryPullRequestDeleteBranchOnMerge"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
