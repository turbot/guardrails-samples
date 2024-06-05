# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Check KMS crypto keys to be rotated regularly"
  description = "Check that all KMS cryptographic keys available within the project are regularly rotated."
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > KMS > Enabled
resource "turbot_policy_setting" "gcp_kms_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/kmsEnabled"
  value    = "Enabled"
}
