resource "turbot_smart_folder" "main" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "AWS CIS v3.0.0 - Section 4 - Monitoring"
  description = "This section contains recommendations for configuring AWS monitoring features."
}
