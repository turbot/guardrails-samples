resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption at Rest for AWS Bedrock Agents"
  description = "Require Amazon Bedrock agents to be encrypted at rest with a customer managed KMS key so you retain full control over the keys protecting agent data."
  akas        = ["aws_bedrock_enforce_encryption_at_rest_for_agents"]
}
