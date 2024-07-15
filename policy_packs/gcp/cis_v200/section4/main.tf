resource "turbot_policy_pack" "main" {
  title       = "GCP CIS v2.0.0 - Section 4 - Virtual Machines"
  description = "This section covers recommendations addressing virtual machines on Google Cloud Platform."
  parent      = "tmod:@turbot/turbot#/"
}
