resource "turbot_policy_pack" "main" {
  title       = "Enforce Content Filtering for AWS Bedrock Guardrails"
  description = "Require harmful-content filters to be configured on Amazon Bedrock guardrails so prompts and responses are screened for hate, insults, sexual, violence, misconduct, and prompt-attack content."
  akas        = ["aws_bedrock_enforce_content_filtering_for_guardrails"]
}
