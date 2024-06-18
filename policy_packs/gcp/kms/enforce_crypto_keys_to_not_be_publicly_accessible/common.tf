# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce GCP KMS Cryptographic Keys to Not Be Publicly Accessible"
  description = "Ensure that there are no publicly accessible GCP KMS cryptographic keys available within the project."
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > KMS > Enabled
resource "turbot_policy_setting" "gcp_kms_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-kms#/policy/types/kmsEnabled"
  value    = "Enabled"
}
