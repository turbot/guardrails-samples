# AWS > Bedrock > Guardrail > Settings
resource "turbot_policy_setting" "aws_bedrock_guardrail_settings" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockGuardrailSettings"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > Bedrock > Guardrail > Settings > Content Policy > Hate Filter Input Strength
resource "turbot_policy_setting" "aws_bedrock_guardrail_settings_content_policy_hate_filter_input_strength" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockGuardrailSettingsContentPolicyHateFilterInputStrength"
  value    = "HIGH"
}

# AWS > Bedrock > Guardrail > Settings > Content Policy > Hate Filter Output Strength
resource "turbot_policy_setting" "aws_bedrock_guardrail_settings_content_policy_hate_filter_output_strength" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockGuardrailSettingsContentPolicyHateFilterOutputStrength"
  value    = "HIGH"
}

# AWS > Bedrock > Guardrail > Settings > Content Policy > Insults Filter Input Strength
resource "turbot_policy_setting" "aws_bedrock_guardrail_settings_content_policy_insults_filter_input_strength" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockGuardrailSettingsContentPolicyInsultsFilterInputStrength"
  value    = "HIGH"
}

# AWS > Bedrock > Guardrail > Settings > Content Policy > Insults Filter Output Strength
resource "turbot_policy_setting" "aws_bedrock_guardrail_settings_content_policy_insults_filter_output_strength" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockGuardrailSettingsContentPolicyInsultsFilterOutputStrength"
  value    = "HIGH"
}

# AWS > Bedrock > Guardrail > Settings > Content Policy > Sexual Filter Input Strength
resource "turbot_policy_setting" "aws_bedrock_guardrail_settings_content_policy_sexual_filter_input_strength" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockGuardrailSettingsContentPolicySexualFilterInputStrength"
  value    = "HIGH"
}

# AWS > Bedrock > Guardrail > Settings > Content Policy > Sexual Filter Output Strength
resource "turbot_policy_setting" "aws_bedrock_guardrail_settings_content_policy_sexual_filter_output_strength" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockGuardrailSettingsContentPolicySexualFilterOutputStrength"
  value    = "HIGH"
}

# AWS > Bedrock > Guardrail > Settings > Content Policy > Violence Filter Input Strength
resource "turbot_policy_setting" "aws_bedrock_guardrail_settings_content_policy_violence_filter_input_strength" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockGuardrailSettingsContentPolicyViolenceFilterInputStrength"
  value    = "HIGH"
}

# AWS > Bedrock > Guardrail > Settings > Content Policy > Violence Filter Output Strength
resource "turbot_policy_setting" "aws_bedrock_guardrail_settings_content_policy_violence_filter_output_strength" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockGuardrailSettingsContentPolicyViolenceFilterOutputStrength"
  value    = "HIGH"
}

# AWS > Bedrock > Guardrail > Settings > Content Policy > Misconduct Filter Input Strength
resource "turbot_policy_setting" "aws_bedrock_guardrail_settings_content_policy_misconduct_filter_input_strength" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockGuardrailSettingsContentPolicyMisconductFilterInputStrength"
  value    = "HIGH"
}

# AWS > Bedrock > Guardrail > Settings > Content Policy > Misconduct Filter Output Strength
resource "turbot_policy_setting" "aws_bedrock_guardrail_settings_content_policy_misconduct_filter_output_strength" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockGuardrailSettingsContentPolicyMisconductFilterOutputStrength"
  value    = "HIGH"
}

# AWS > Bedrock > Guardrail > Settings > Content Policy > Prompt Attack Filter Input Strength
resource "turbot_policy_setting" "aws_bedrock_guardrail_settings_content_policy_prompt_attack_filter_input_strength" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockGuardrailSettingsContentPolicyPromptAttackFilterInputStrength"
  value    = "HIGH"
}
