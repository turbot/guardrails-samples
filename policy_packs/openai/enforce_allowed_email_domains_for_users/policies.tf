# OpenAI > User > Allowed > Email Domain
resource "turbot_policy_setting" "openai_user_allowed_email_domain" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/openai#/policy/types/userAllowedEmailDomain"
  value    = "Check: Allowed"
  # value    = "Enforce: Delete if domain not allowed"
}

# OpenAI > User > Allowed > Email Domain > Domains
resource "turbot_policy_setting" "openai_user_allowed_email_domain_domains" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/openai#/policy/types/userAllowedEmailDomainDomains"
  value    = <<-EOT
    - "acme.com"
    - "*.acme.com"
    EOT
}
