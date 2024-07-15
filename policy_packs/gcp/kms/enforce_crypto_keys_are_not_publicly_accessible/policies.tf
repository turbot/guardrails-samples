# GCP > KMS > Crypto Key > Policy > Trusted Access
resource "turbot_policy_setting" "gcp_kms_crypto_key_policy_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/cryptoKeyPolicyTrustedAccess"
  value    = "Check: Trusted Access > *"
  # value    = "Enforce: Trusted Access > *"
}

# GCP > KMS > Crypto Key > Policy > Trusted Access > All Users
resource "turbot_policy_setting" "gcp_kms_crypto_key_policy_trusted_access_all_users" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/cryptoKeyPolicyTrustedAllUsers"
  value    = "Do not allow allUsers"
}

# GCP > KMS > Crypto Key > Policy > Trusted Access > All Authenticated
resource "turbot_policy_setting" "gcp_kms_crypto_key_policy_trusted_access_all_authenticated" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/cryptoKeyPolicyTrustedAllAuthenticated"
  value    = "Do not allow allAuthenticatedUsers"
}
