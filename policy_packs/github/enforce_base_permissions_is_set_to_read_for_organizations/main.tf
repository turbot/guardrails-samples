resource "turbot_policy_pack" "main" {
  title       = "Enforce Base Permissions Is Set to Read for GitHub Organizations"
  description = "Enforcing read member privileges base permissions for GitHub organizations ensures controlled access to repositories, minimizing the risk of unauthorized changes and enhancing security."
  akas        = ["github_enforce_base_permissions_is_set_to_read_for_organizations"]
}
