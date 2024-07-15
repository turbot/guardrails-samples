resource "turbot_policy_pack" "main" {
  title       = "Azure CIS v2.0.0 - Section 1 - Identity and Access Management"
  description = "This section contains recommendations for configuring Azure Identity and Access Management features."
  akas        = ["azure_cis_v200_section1"]
}
