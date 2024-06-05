# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect KMS cryptographic keys to be rotated regularly"
  description = "Detect KMS cryptographic keys to be rotated regularly"
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > KMS > Enabled
resource "turbot_policy_setting" "gcp_kms_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/kmsEnabled"
  value    = "Enabled"
}
