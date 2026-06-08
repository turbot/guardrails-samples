resource "turbot_policy_pack" "main" {
  title       = "Enforce API Key Rotation for OpenAI"
  description = "Promote OpenAI API key rotation by treating keys that have not been used recently as inactive and optionally deleting them."
  akas        = ["openai_enforce_api_key_rotation"]
}
