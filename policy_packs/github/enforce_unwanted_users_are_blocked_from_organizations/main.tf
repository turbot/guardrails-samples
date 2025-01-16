resource "turbot_policy_pack" "main" {
  title       = "Enforce Unwanted Users Are Blocked from GitHub Organizations"
  description = "Enforcing the blocking of unwanted users from GitHub organizations is essential to safeguard repositories and sensitive data from unauthorized access and potential threats."
  akas        = ["github_enforce_unwanted_users_are_blocked_from_organizations"]
}
