resource "turbot_policy_pack" "main" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 7 - Virtual Machines"
  description = "This section contains recommendations for configuring Azure virtual machines."
}
