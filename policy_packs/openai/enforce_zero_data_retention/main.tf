resource "turbot_policy_pack" "main" {
  title       = "Enforce Zero Data Retention for OpenAI"
  description = "Verify that the OpenAI organization has Zero Data Retention (ZDR) and Modified Abuse Monitoring enabled, based on an operator attestation."
  akas        = ["openai_enforce_zero_data_retention"]
}
