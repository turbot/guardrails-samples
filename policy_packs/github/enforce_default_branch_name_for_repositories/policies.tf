# GitHub > Repository > Default Branch
resource "turbot_policy_setting" "github_repository_default_branch" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/repositoryDefaultBranch"
  value    = "Check: Set to `Default Branch > Name`"
  # value    = "Enforce: Set to `Default Branch > Name`"
}

# GitHub > Repository > Default Branch > Name
resource "turbot_policy_setting" "github_repository_default_branch_name" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/repositoryDefaultBranchName"
  value    = "main"
}
