# AWS > Bedrock > Permissions
resource "turbot_policy_setting" "aws_bedrock_permissions" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockPermissions"
  value    = "Enabled if AWS > Bedrock > Enabled & AWS > Bedrock > API Enabled"
  # value    = "Enabled"
  # value    = "Disabled"
}

# AWS > Bedrock > Enabled
resource "turbot_policy_setting" "aws_bedrock_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockEnabled"
  value    = "Enabled"
  # value    = "Disabled"
}

# AWS > Bedrock > API Enabled
resource "turbot_policy_setting" "aws_bedrock_api_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockApiEnabled"
  value    = "Enabled"
  # value    = "Disabled"
}
