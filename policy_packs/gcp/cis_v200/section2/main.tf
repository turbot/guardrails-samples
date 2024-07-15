# Smart Folder
resource "turbot_policy_pack" "main" {
  title       = "GCP CIS v2.0.0 - Section 2 - Logging and Monitoring"
  description = "This section covers recommendations addressing Logging and Monitoring on Google Cloud Platform."
  parent      = "tmod:@turbot/turbot#/"
}
