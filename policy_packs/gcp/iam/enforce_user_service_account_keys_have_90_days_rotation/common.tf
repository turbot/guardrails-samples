# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce GCP IAM user-managed service account keys to not have rotation period of more than 90 days"
  description = "Delete GCP IAM user-managed service account keys that have rotation period of more than 90 days."
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > IAM > Enabled
resource "turbot_policy_setting" "gcp_iam_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/iamEnabled"
  value    = "Enabled"
}
