# GCP > Storage > Bucket > Policy > Trusted Access
resource "turbot_policy_setting" "gcp_storage_bucket_policy_trusted_access" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketPolicyTrustedAccess"
  value    = "Check: Trusted Access > *"
  # value    = "Enforce: Trusted Access > *"
}

# GCP > Storage > Bucket > Policy > Trusted Access > All Users
resource "turbot_policy_setting" "gcp_storage_bucket_policy_trusted_access_all_users" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketPolicyTrustedAllUsers"
  value    = "Do not allow allUsers"
}

# GCP > Storage > Bucket > Policy > Trusted Access > All Authenticated
resource "turbot_policy_setting" "gcp_storage_bucket_policy_trusted_access_all_authenticated" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketPolicyTrustedAllAuthenticated"
  value    = "Do not allow allAuthenticatedUsers"
}
