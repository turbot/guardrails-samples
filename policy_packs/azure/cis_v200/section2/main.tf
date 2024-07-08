# Smart Folder
resource "turbot_smart_folder" "main" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 2 - Microsoft Defender"
  description = "This section contains recommendations to consider for tenant-wide security policies and plans related to Microsoft Defender."
}
