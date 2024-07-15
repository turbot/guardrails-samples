resource "turbot_policy_pack" "main" {
  title       = "Azure CIS v2.0.0 - Section 5 - Logging and Monitoring"
  description = "This section contains recommendations for configuring Azure logging and monitoring features."
  akas        = ["azure_cis_v200_section5"]
}
