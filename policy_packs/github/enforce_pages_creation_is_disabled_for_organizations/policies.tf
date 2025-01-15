# GitHub > Organization > Member Privileges > Pages Creation
resource "turbot_policy_setting" "github_organization_member_privileges_pages_creation" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/organizationMemberPrivilegesPagesCreation"
  value    = "Check: Disabled"
  # value    = "Enforce: Disabled"
}
