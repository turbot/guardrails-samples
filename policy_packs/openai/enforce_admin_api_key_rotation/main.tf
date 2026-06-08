resource "turbot_policy_pack" "main" {
  title       = "Enforce Admin API Key Rotation for OpenAI"
  description = "Promote OpenAI Admin API key rotation by treating admin keys that have not been used recently as inactive and optionally deleting them."
  akas        = ["openai_enforce_admin_api_key_rotation"]
}
