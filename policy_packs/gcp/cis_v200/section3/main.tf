resource "turbot_policy_pack" "main" {
  title       = "GCP CIS v2.0.0 - Section 3 - Networking"
  description = "This section covers recommendations addressing networking on Google Cloud Platform."
  parent      = "tmod:@turbot/turbot#/"
}
