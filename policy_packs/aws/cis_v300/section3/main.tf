resource "turbot_policy_pack" "main" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "AWS CIS v3.0.0 - Section 3 - Logging"
  description = "This section contains recommendations for configuring logging related options."
}
