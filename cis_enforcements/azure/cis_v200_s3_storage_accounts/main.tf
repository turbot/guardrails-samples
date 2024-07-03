# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Azure CIS v2.0.0 - Section 3 - Storage Accounts"
  description = "This section contains recommendations for configuring Azure Storage Accounts features."
  parent      = "tmod:@turbot/turbot#/"
}
