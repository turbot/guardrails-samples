# Smart Folder
resource "turbot_smart_folder" "main" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 4 - Database Services"
  description = "This section covers security recommendations to follow to set general database services policies on an Azure Subscription. Subsections will address specific database types."
}
