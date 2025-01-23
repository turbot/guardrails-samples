resource "turbot_policy_pack" "main" {
  title       = "Enforce Dependabot Alerts Are Enabled for GitHub Repositories"
  description = "Enforcing dependabot alerts in GitHub repositories is essential to ensure vulnerabilities in dependencies are identified and addressed, safeguarding code integrity and security."
  akas        = ["github_enforce_dependabot_alerts_are_enabled_for_repositories"]
}
