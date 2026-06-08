resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS Bedrock API Permissions Lockdown"
  description = "Govern which Guardrails-managed identities can access the Amazon Bedrock service and API by enabling Bedrock permissions, service access, and API access."
  akas        = ["aws_bedrock_enforce_bedrock_api_permissions_lockdown"]
}
