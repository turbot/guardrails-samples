# Smart Folder
resource "turbot_policy_pack" "main" {
  title       = "GCP CIS v2.0.0 - Section 1 - Identity and Access Management"
  description = "This section covers recommendations addressing Identity and Access Management on Google Cloud Platform."
  parent      = "tmod:@turbot/turbot#/"
}
