resource "turbot_policy_pack" "main" {
  title       = "AWS CIS v3.0.0 - Section 2 - Storage"
  description = "This section contains recommendations for configuring AWS Storage."
  akas        = ["aws_cis_v300_section2"]
}
