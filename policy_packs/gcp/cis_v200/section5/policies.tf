# GCP > Storage > Bucket > Policy > Trusted Access
resource "turbot_policy_setting" "gcp_storage_bucket_policy_trusted_access" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketPolicyTrustedAccess"
  note     = "GCP CIS v2.0.0 - Control: 5.1"
  value    = "Check: Trusted Access > *"
  # value    = "Enforce: Trusted Access > *"
}

# GCP > Storage > Bucket > Policy > Trusted Domains
resource "turbot_policy_setting" "gcp_storage_bucket_policy_trusted_domains" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketPolicyTrustedDomains"
  note     = "GCP CIS v2.0.0 - Control: 5.1"
  # GCP Domains that are trusted for access
  value = <<-EOT
  - company.com
  - company-dev.org
  EOT
}

# GCP > Storage > Bucket > Policy > Trusted Groups
resource "turbot_policy_setting" "gcp_storage_bucket_policy_trusted_groups" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketPolicyTrustedGroups"
  note     = "GCP CIS v2.0.0 - Control: 5.1"
  # GCP Groups that are trusted for access
  value = <<-EOT
  - notification@company.com
  - "*@company.com"
  EOT
}

# GCP > Storage > Bucket > Policy > Trusted Service Accounts
resource "turbot_policy_setting" "gcp_storage_bucket_policy_trusted_service_accounts" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketPolicyTrustedServiceAccounts"
  note     = "GCP CIS v2.0.0 - Control: 5.1"
  # GCP Service Accounts that are trusted for access
  value = <<-EOT
  - project-owner@dev-aaa.iam.gserviceaccount.com
  - "*"
  EOT
}

# GCP > Storage > Bucket > Policy > Trusted Users
resource "turbot_policy_setting" "gcp_storage_bucket_policy_trusted_users" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketPolicyTrustedUsers"
  note     = "GCP CIS v2.0.0 - Control: 5.1"
  # GCP Users that are trusted for access
  value = <<-EOT
  - "dummy@gmail.com"
  - "*@mycompany.com"
  EOT
}

# GCP > Storage > Bucket > Policy > Trusted Projects
resource "turbot_policy_setting" "gcp_storage_bucket_policy_trusted_projects" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketPolicyTrustedProjects"
  note     = "GCP CIS v2.0.0 - Control: 5.1"
  # GCP Projects that are trusted for access
  value = <<-EOT
  - "dev-aaa"
  - "dev-aab"
  EOT
}

# GCP > Storage > Bucket > Policy > Trusted All Users
resource "turbot_policy_setting" "gcp_storage_bucket_policy_trusted_all_users" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketPolicyTrustedAllUsers"
  note     = "GCP CIS v2.0.0 - Control: 5.1"
  # Anonymous that are trusted for access
  value = "Allow allUsers (Anonymous Access)"
  # value = "Do not allow allUsers"
}

# GCP > Storage > Bucket > Policy > Trusted All Authenticated
resource "turbot_policy_setting" "gcp_storage_bucket_policy_trusted_all_authenticated" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketPolicyTrustedAllAuthenticated"
  note     = "GCP CIS v2.0.0 - Control: 5.1"
  # Granted public access
  value = "Allow allAuthenticatedUsers (Public Access)"
  # value = "Do not allow allAuthenticatedUsers"
}

# GCP > Storage > Bucket > Access Control
resource "turbot_policy_setting" "gcp_storage_bucket_access_control" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketAccessControl"
  note     = "GCP CIS v2.0.0 - Control: 5.2"
  value    = "Check: Uniform"
  # value    = "Enforce: Uniform"
}
