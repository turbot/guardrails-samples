resource "turbot_policy_pack" "main" {
  title       = "AWS CIS v3.0.0 - Section 1 - IAM"
  description = "This section contains recommendations for configuring identity and access management related options."
  akas        = ["aws_cis_v300_section1"]
}
