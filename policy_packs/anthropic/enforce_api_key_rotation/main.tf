resource "turbot_policy_pack" "main" {
  title       = "Enforce API Key Rotation for Anthropic"
  description = "Reduce the blast radius of leaked credentials by requiring Anthropic API keys to be rotated, treating keys older than a set age as inactive."
  akas        = ["anthropic_enforce_api_key_rotation"]
}
