# AWS > Region > Stack > Source
resource turbot_policy_setting "aws_iam_regional_access_analyzer" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws#/policy/types/regionStack"
  value    = "Check: Configured"
  #value   = "Enforce: Configured"
  note     = "AWS CIS v3.0.0 - Controls: 1.20"
}

# AWS > Region > Stack > Source
resource turbot_policy_setting "aws_iam_regional_access_analyzer_source" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws#/policy/types/regionStackSource"
  note = "Deploys an access analyzer of the specified name in each region that Guardrails tracks."
  value = <<EOV
resource "aws_accessanalyzer_analyzer" "cis_access_analyzer" {
  analyzer_name = "access_analyzer"
  type          = "ACCOUNT"
}
EOV
}