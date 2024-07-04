# Smart Folder
resource "turbot_smart_folder" "pack" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 2 - Microsoft Defender"
  description = "This section contains recommendations to consider for tenant-wide security policies and plans related to Microsoft Defender. Please note that because Microsoft Defender products require additional licensing, all Microsoft Defender plan recommendations in subsection 2.1 are assigned as 'Level 2.'"
}
