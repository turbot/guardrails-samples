resource "turbot_smart_folder" "main" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "AWS CIS v3.0.0 - Section 5 - Networking"
  description = "This section contains recommendations for configuring security-related aspects of AWS Virtual Private Cloud (VPC)."
}
