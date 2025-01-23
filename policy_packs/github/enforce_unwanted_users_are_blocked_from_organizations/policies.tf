# GitHub > Organization > Blocked Users
resource "turbot_policy_setting" "github_organization_blocked_users" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/organizationBlockedUsers"
  value    = "Check: Block Users"
  # value    = "Enforce: Block Users"
}

# GitHub > Organization > Blocked Users > Usernames
resource "turbot_policy_setting" "github_organization_blocked_users_usernames" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/organizationBlockedUsersUsernames"
  value    = []
  # value = <<-EOT
  #   - "octocat"
  #   EOT
}
