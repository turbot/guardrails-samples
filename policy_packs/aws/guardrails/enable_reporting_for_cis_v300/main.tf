resource "turbot_policy_pack" "main" {
  title       = "Enable Reporting for AWS CIS v3.0.0"
  description = "Enable AWS CIS v3.0.0 reporting in guardrails to check security best practices."
  akas        = ["aws_guardrails_enable_reporting_for_cis_v300"]

}
