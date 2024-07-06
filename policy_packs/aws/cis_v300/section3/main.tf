resource "turbot_smart_folder" "main" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "AWS CIS v3.0.0 - Section 3 - Logging"
  description = "This section contains recommendations for configuring logging related options."
}
