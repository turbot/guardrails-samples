# Smart Folder
resource "turbot_smart_folder" "main" {
  title       = "GCP CIS v2.0.0 - Section 4 - Virtual Machines"
  description = "This section covers recommendations addressing virtual machines on Google Cloud Platform."
  parent      = "tmod:@turbot/turbot#/"
}
