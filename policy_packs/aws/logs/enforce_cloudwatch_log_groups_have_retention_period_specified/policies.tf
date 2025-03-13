# AWS > CloudWatch > Log Group > Configured
resource "turbot_policy_setting" "log_group_configured" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-logs#/policy/types/logGroupConfigured"
  value    = "Check: Per Configured > Source (unless claimed by a stack)"
  # value    = "Enforce: Per Configured > Source (unless claimed by a stack)"
}

# AWS > CloudWatch > Log Group > Configured > Source
resource "turbot_policy_setting" "log_group_configured_source" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-logs#/policy/types/logGroupConfiguredSource"
  # Define the Terraform configuration to specify retention policy
  value    = <<EOT
# This template configures retention period for CloudWatch Log Groups
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Get the existing log group name from the resource metadata
locals {
  # Extract log group name from the resource metadata
  log_group_name = turbot.resource.logGroupName
}

# Configure retention period on the existing log group
resource "aws_cloudwatch_log_group" "log_group" {
  name              = local.log_group_name
  retention_in_days = 30
  # The log group already exists, so we skip creation
  lifecycle {
    ignore_changes = [kms_key_id, tags]
  }
}
EOT
}
