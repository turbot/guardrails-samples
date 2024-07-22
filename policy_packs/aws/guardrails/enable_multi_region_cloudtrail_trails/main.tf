resource "turbot_policy_pack" "main" {
  title       = "Enable Multi-Region CloudTrail Trails In AWS Accounts"
  description = "Ensure that all actions taken within your AWS environment are consistently logged, enhancing security monitoring, supporting incident response, and ensuring compliance with regulatory requirements."
  akas        = ["aws_guardrails_enable_multi_region_cloudtrail_trails"]
}
