terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
}

# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce AWS Lambda Functions to Restrict Public Access"
  description = "Prevent unauthorized users from invoking functions, which can lead to security vulnerabilities and potential data breaches."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > Lambda > Enabled
resource "turbot_policy_setting" "aws_lambda_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/lambdaEnabled"
  value    = "Enabled"
}
