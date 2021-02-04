# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest

# AWS > CloudTrail > Trail > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-cloudtrail/inspect#/control/types/trailEncryptionAtRest
resource "turbot_policy_setting" "aws_cloudtrail_trail_encryption_at_rest" {
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/trailEncryptionAtRest"
  value    = "Check: Customer managed key"
# Note: no Check: AWS managed key or higher available at the moment
}
# AWS > Lambda > Function > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-lambda/inspect#/control/types/functionEncryptionAtRest
resource "turbot_policy_setting" "lambda_function_ennvar_encryption_at_rest" {
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/functionEncryptionAtRest"
  value    = "Check: AWS managed key or higher"
}

# AWS > Logs > Log Group > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-logs/inspect#/control/types/logGroupEncryptionAtRest
resource "turbot_policy_setting" "cloudwatch_logs_encryption_at_rest" {
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-logs#/policy/types/logGroupEncryptionAtRest"
  value    = "Check: AWS SSE or higher"
}

# AWS > SNS > Topic > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-sns/inspect#/control/types/topicEncryptionAtRest
resource "turbot_policy_setting" "aws_sns_topic_encrypted" {
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-sns#/policy/types/topicEncryptionAtRest"
  value    = "Check: AWS managed key or higher"
}

# ## DynamoDB
# resource "turbot_policy_setting" "aws_dynamodb_table_encryption_at_rest" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-dynamodb#/policy/types/tableEncryptionAtRest"
#   value    = "Check: AWS managed key or higher"
# }

# ## Redshift
# resource "turbot_policy_setting" "redshift_cluster_encryption_at_rest" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-redshift#/policy/types/clusterEncryptionAtRest"
#   value    = "Check: AWS managed key or higher"
# }

# ## Secrets Manager
# resource "turbot_policy_setting" "secrets_manager_encryption_at_rest" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-secretsmanager#/policy/types/secretEncryptionAtRest"
#   value    = "Check: AWS managed key or higher"
# }

# ## SQS
# resource "turbot_policy_setting" "aws_sqs_queue_encrypted" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-sqs#/policy/types/queueEncryptionAtRest"
#   value    = "Check: AWS managed key or higher"
# }


# ## SSM Parameters
# resource "turbot_policy_setting" "aws_ssm_param_encryption_at_rest" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-ssm#/policy/types/ssmParameterEncryptionAtRest"
#   value    = "Check: AWS managed key or higher"
# }
