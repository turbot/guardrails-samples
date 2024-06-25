resource "turbot_smart_folder" "pack" {
  title       = "Enforce Encryption for Secrets is Enabled for GCP GKE Clusters"
  description = "Ensure that secrets, such as passwords and API keys, are encrypted, thereby safeguarding them from unauthorized access and potential breaches."
  parent      = "tmod:@turbot/turbot#/"
}
