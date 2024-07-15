resource "turbot_policy_pack" "main" {
  title       = "GCP CIS v2.0.0 - Section 5 - Storage"
  description = "This section covers recommendations addressing storage on Google Cloud Platform."
  parent      = "tmod:@turbot/turbot#/"
}
