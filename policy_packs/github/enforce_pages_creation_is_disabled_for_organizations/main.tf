resource "turbot_policy_pack" "main" {
  title       = "Enforce Pages Creation is Disabled for GitHub Organizations"
  description = "Disabling member privileges pages creation for GitHub organizations helps prevent unauthorized publication of sensitive content and ensures compliance with organizational policies."
  akas        = ["github_enforce_pages_creation_is_disabled_for_organizations"]
}
