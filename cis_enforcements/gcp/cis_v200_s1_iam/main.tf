# Smart Folder
resource "turbot_smart_folder" "pack" {
  title       = "GCP CIS v2.0.0 - Section 1 - Identity and Access Management"
  description = "This section covers recommendations addressing Identity and Access Management on Google Cloud Platform."
  parent      = "tmod:@turbot/turbot#/"
}
