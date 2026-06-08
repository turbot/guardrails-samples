resource "turbot_policy_pack" "main" {
  title       = "Enforce Allowed Email Domains for Anthropic Users"
  description = "Restrict Anthropic organization membership to trusted identities by requiring user email addresses to match an approved set of domains."
  akas        = ["anthropic_enforce_allowed_email_domains_for_users"]
}
