resource "turbot_policy_pack" "main" {
  akas        = ["aws_guardrails_enable_logging_bucket_stack"]
  title       = "Enable Logging Bucket Stack in Guardrails"
  description = "The Guardrails Logging Bucket stack configures an AWS S3 Bucket for use as a destination for logs from other AWS services."
}
