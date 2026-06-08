# AWS > Bedrock > Settings > Model Invocation Logging Configuration
resource "turbot_policy_setting" "aws_bedrock_settings_model_invocation_logging_configuration" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/settingsModelInvocationLoggingConfiguration"
  value    = "Check: Enabled per `Model Invocation Logging Configuration > *`"
  # value    = "Check: Disabled"
  # value    = "Enforce: Enabled per `Model Invocation Logging Configuration > *`"
  # value    = "Enforce: Disabled"
}

# AWS > Bedrock > Settings > Model Invocation Logging Configuration > Data Delivery
resource "turbot_policy_setting" "aws_bedrock_settings_model_invocation_logging_configuration_data_delivery" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/settingsModelInvocationLoggingConfigurationDataDelivery"
  value    = <<-EOT
    - "Text"
    - "Image"
    - "Embedding"
    - "Video"
    EOT
}

# AWS > Bedrock > Settings > Model Invocation Logging Configuration > Logging Destination
#
# The logging destination requires environment-specific values (S3 bucket, CloudWatch log
# group, and a service role ARN). Uncomment and set these to enable enforcement.
#
# resource "turbot_policy_setting" "aws_bedrock_settings_model_invocation_logging_configuration_logging_destination" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-bedrock#/policy/types/settingsModelInvocationLoggingConfigurationLoggingDestination"
#   value    = "Both S3 and Cloudwatch Logs"
#   # value    = "S3 only"
#   # value    = "Cloudwatch Logs only"
# }
