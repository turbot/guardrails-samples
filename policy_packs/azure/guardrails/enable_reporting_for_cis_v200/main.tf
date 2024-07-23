resource "turbot_policy_pack" "main" {
  akas        = ["azure_guardrails_enable_reporting_for_cis_v200"]
  title       = "Enable Reporting for Azure CIS v2.0.0"
  description = "Enable Azure CIS v2.0.0 reporting in guardrails to check security best practices."
}
