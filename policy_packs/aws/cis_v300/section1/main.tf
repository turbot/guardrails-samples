resource "turbot_smart_folder" "main" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "AWS CIS v3.0.0 - Section 1 - IAM"
  description = "This section contains recommendations for configuring identity and access management related options."
}
