# Smart Folder
resource "turbot_smart_folder" "main" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 9 - App Service"
  description = "This section covers security recommendations for Azure App Service."
}

