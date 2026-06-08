resource "turbot_policy_pack" "main" {
  title       = "Enforce Allowed Email Domains for OpenAI Users"
  description = "Restrict OpenAI organization users to an allowlist of email-address domains, optionally deleting users whose domain is not allowed."
  akas        = ["openai_enforce_allowed_email_domains_for_users"]
}
