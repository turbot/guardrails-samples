resource "turbot_policy_pack" "main" {
  title       = "Enforce Approved Models for OpenAI Projects"
  description = "Restrict OpenAI projects to an approved list of models by checking project rate-limit entries against an allowlist."
  akas        = ["openai_enforce_approved_models_for_projects"]
}
