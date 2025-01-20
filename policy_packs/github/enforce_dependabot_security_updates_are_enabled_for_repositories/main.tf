resource "turbot_policy_pack" "main" {
  title       = "Enforce Dependabot Security Updates Are Enabled for GitHub Repositories"
  description = "Enforcing dependabot security updates ensures GitHub repositories automatically receive critical updates to dependencies, reducing vulnerabilities and enhancing security."
  akas        = ["github_enforce_dependabot_security_updates_are_disabled_for_repositories"]
}
