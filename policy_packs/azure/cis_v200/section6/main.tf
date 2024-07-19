resource "turbot_policy_pack" "main" {
  title       = "Azure CIS v2.0.0 - Section 6 - Networking"
  description = "This section covers security recommendations to follow in order to set networking policies on an Azure subscription."
  akas        = ["azure_cis_v200_section6"]
}
