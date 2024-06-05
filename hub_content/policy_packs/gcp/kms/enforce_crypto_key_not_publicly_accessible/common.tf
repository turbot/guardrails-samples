# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce KMS cryptographic keys to not be publicly accessible"
  description = "Enforce KMS cryptographic keys to not be publicly accessible"
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > KMS > Enabled
resource "turbot_policy_setting" "gcp_kms_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/kmsEnabled"
  value    = "Enabled"
}
