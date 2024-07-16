# GCP > Project > Policy > Trusted Access
resource "turbot_policy_setting" "gcp_iam_project_iam_policy_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/projectIamPolicyTrustedAccess"
  # value    = "Check: Trusted Access > *"
  value = "Enforce: Trusted Access > *"
}

# GCP > Project > Policy > Trusted Access > Domains
resource "turbot_policy_setting" "gcp_iam_project_iam_policy_trusted_domains" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/projectIamPolicyTrustedDomains"
  value    = <<-EOT
    - turbot.com
    - guardrails.com
    EOT
}
