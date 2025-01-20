# GitHub > Organization > Member Privileges > Base Permissions
resource "turbot_policy_setting" "github_organization_member_privileges_base_permissions" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/organizationMemberPrivilegesBasePermissions"
  value    = "Check: Read"
  # value    = "Enforce: Read"
}
