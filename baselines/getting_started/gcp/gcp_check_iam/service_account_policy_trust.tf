# IAM Service Account Policy Trusted Access only trusts specific domains.
# Trusted Domains are defined in Public Access Baseline.

resource "turbot_policy_setting" "iam_service_account_policy_trusted_access" {
  resource = turbot_smart_folder.gcp_iam.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountPolicyTrustedAccess"
  value    = "Check: Trusted Access > *"
                 # Enforce: Trusted Access > *"
}

# # Already Set globally in the Public Access Smart Folder Baseline, commenting out incase needed to enable here
# # List of Trusted Domains
# # Could also consider Trusted Groups, Service Accounts, and Users

# resource "turbot_policy_setting" "iam_service_account_policy_trusted_domains" {
#   resource = turbot_smart_folder.gcp_iam.id
#   type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountPolicyTrustedDomains"
#   value    = <<-EOT
#     - "*" # allows all, adjust for specific domains (e.g. turbot.com)
#     - "turbot.com"
# EOT
# }