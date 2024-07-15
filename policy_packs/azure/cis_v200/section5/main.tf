resource "turbot_policy_pack" "main" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 5 - Logging and Monitoring"
  description = "This section contains recommendations for configuring Azure logging and monitoring features."
}
