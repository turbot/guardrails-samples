# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce Lambda functions to restrict public access"
  description = "Manage access to resources in the AWS Cloud by ensuring AWS Lambda functions cannot be publicly accessed."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > Lambda > Enabled
resource "turbot_policy_setting" "aws_lambda_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/lambdaEnabled"
  value    = "Enabled"
}
