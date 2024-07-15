resource "turbot_policy_pack" "main" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 8 - Key Vault"
  description = "This section covers security recommendations to follow for the configuration and use of Azure Key Vault."
}
