# GitHub > Organization > Member Privileges > Repository Forking
resource "turbot_policy_setting" "github_organization_member_privileges_repository_forking" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/github#/policy/types/organizationMemberPrivilegesRepositoryForking"
  value    = "Check: Deny forking of private repositories"
  # value    = "Enforce: Deny forking of private repositories"
}
