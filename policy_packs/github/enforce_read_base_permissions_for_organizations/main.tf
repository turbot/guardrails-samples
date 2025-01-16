resource "turbot_policy_pack" "main" {
  title       = "Enforce Read Base Permissions for GitHub Organizations"
  description = "Enforcing read member privileges base permissions for GitHub organizations ensures controlled access to repositories, minimizing the risk of unauthorized changes and enhancing security."
  akas        = ["github_enforce_read_base_permissions_for_organizations"]
}
