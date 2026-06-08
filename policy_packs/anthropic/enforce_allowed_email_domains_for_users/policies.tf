# Anthropic > User > Allowed > Email Domain
resource "turbot_policy_setting" "anthropic_user_allowed_email_domain" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/anthropic#/policy/types/userAllowedEmailDomain"
  value    = "Check: Allowed"
  # value    = "Enforce: Delete if domain not allowed"
}

# Anthropic > User > Allowed > Email Domain > Domains
resource "turbot_policy_setting" "anthropic_user_allowed_email_domain_domains" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/anthropic#/policy/types/userAllowedEmailDomainDomains"
  value    = <<-EOT
    - "turbot.com"
    - "*.turbot.com"
    EOT
}
