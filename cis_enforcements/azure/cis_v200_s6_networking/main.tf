# Smart Folder
resource "turbot_smart_folder" "pack" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 6 - Networking"
  description = "This section covers security recommendations to follow in order to set networking policies on an Azure subscription."
}
