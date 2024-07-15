resource "turbot_policy_pack" "main" {
  title       = "Azure CIS v2.0.0 - Section 7 - Virtual Machines"
  description = "This section contains recommendations for configuring Azure virtual machines."
  akas        = ["azure_cis_v200_section7"]
}
