# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce GCP IAM User-Managed Service Accounts to Not Have Admin Privileges"
  description = "Delete GCP IAM user-managed service accounts that have admin privileges."
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > IAM > Enabled
resource "turbot_policy_setting" "gcp_iam_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/iamEnabled"
  value    = "Enabled"
}
