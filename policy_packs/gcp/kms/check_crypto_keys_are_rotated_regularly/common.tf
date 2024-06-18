# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Check If GCP KMS Crypto Keys Are Rotated Regularly"
  description = "Check if GCP KMS cryptographic keys available within the project are rotated regularly."
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > KMS > Enabled
resource "turbot_policy_setting" "gcp_kms_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/kmsEnabled"
  value    = "Enabled"
}
