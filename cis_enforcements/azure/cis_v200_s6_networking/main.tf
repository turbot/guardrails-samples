# Policy Pack
resource "turbot_smart_folder" "pack" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 6 - Networking"
  description = "This section contains recommendations for configuring Azure Networking features."
}
