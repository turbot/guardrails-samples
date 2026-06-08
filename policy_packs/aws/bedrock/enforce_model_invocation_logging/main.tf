resource "turbot_policy_pack" "main" {
  title       = "Enforce Model Invocation Logging for AWS Bedrock"
  description = "Capture a full audit trail of Amazon Bedrock model invocations by requiring model invocation logging to be enabled."
  akas        = ["aws_bedrock_enforce_model_invocation_logging"]
}
