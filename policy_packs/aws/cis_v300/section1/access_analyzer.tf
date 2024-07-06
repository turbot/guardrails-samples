# AWS > Region > Stack > Source
resource "turbot_policy_setting" "aws_iam_regional_access_analyzer" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws#/policy/types/regionStack"
  note     = "AWS CIS v3.0.0 - Controls: 1.20"
  value    = "Check: Configured"
  # value    = "Enforce: Configured" 
}

# AWS > Region > Stack > Source
resource "turbot_policy_setting" "aws_iam_regional_access_analyzer_source" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws#/policy/types/regionStackSource"
  note     = "AWS CIS v3.0.0 - Controls: 1.20"
  value    = <<-EOT
    resource "aws_accessanalyzer_analyzer" "cis_access_analyzer" {
      analyzer_name = "access_analyzer"
      type          = "ACCOUNT"
    }
    EOT
}