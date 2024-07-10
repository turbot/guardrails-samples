# Smart Folder
resource "turbot_smart_folder" "main" {
  title       = "GCP CIS v2.0.0 - Section 6 - Cloud SQL Database Services"
  description = "This section covers security recommendations to follow to secure Cloud SQL database services."
  parent      = "tmod:@turbot/turbot#/"
}
