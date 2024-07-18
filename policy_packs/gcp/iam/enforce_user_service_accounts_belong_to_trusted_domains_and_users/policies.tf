# GCP > IAM > Service Account > Policy > Trusted Access
resource "turbot_policy_setting" "gcp_iam_service_account_policy_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountPolicyTrustedAccess"
  value    = "Check: Trusted Access > *"
  # value    = "Enforce: Trusted Access > *"
}

# GCP > IAM > Service Account > Policy > Trusted Access > Domains
resource "turbot_policy_setting" "gcp_iam_service_account_policy_trusted_domains" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountPolicyTrustedDomains"
  value    = <<-EOT
    - example.com
    - acme.com
  EOT
}

# GCP > IAM > Service Account > Policy > Trusted Access > Users
resource "turbot_policy_setting" "gcp_iam_service_account_policy_trusted_users" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountPolicyTrustedUsers"
  value    = <<-EOT
    - "*@example.com"
    - "*@acme.com"
  EOT
}
