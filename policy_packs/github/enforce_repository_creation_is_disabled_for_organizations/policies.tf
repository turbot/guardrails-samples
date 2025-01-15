# GitHub > Organization > Member Privileges > Repository Creation
resource "turbot_policy_setting" "github_organization_member_privileges_repository_creation" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/organizationMemberPrivilegesRepositoryCreation"
  value    = "Check: Disabled"
  # value    = "Enforce: Disabled"
}
