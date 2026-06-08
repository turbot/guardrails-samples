# AWS > Bedrock > Enforced Guardrail Configuration > Settings
resource "turbot_policy_setting" "aws_bedrock_enforced_guardrail_configuration_settings" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/enforcedGuardrailConfigurationSettings"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > Bedrock > Enforced Guardrail Configuration > Settings > Guardrail > Identifier
#
# The guardrail identifier and version are environment-specific. Uncomment and set
# these to the guardrail you want enforced before switching the Settings policy to
# Enforce.
#
# resource "turbot_policy_setting" "aws_bedrock_enforced_guardrail_configuration_settings_guardrail_identifier" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-bedrock#/policy/types/enforcedGuardrailConfigurationSettingsGuardrailIdentifier"
#   value    = "<your-guardrail-id-or-arn>"
# }

# AWS > Bedrock > Enforced Guardrail Configuration > Settings > Guardrail > Version
#
# resource "turbot_policy_setting" "aws_bedrock_enforced_guardrail_configuration_settings_guardrail_version" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-bedrock#/policy/types/enforcedGuardrailConfigurationSettingsGuardrailVersion"
#   value    = 1
# }
