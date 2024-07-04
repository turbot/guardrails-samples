# Smart Folder
resource "turbot_smart_folder" "pack" {
  title       = "Azure CIS v2.0.0 - Section 3 - Storage Accounts"
  description = "This section covers security recommendations to follow to set storage account policies on an Azure Subscription. An Azure storage account provides a unique namespace to store and access Azure Storage data objects."
  parent      = "tmod:@turbot/turbot#/"
}
