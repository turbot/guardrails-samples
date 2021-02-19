locals {
  access_key        = aws_iam_access_key.turbot_firehose_user_access_key.id
  secret_access_key = aws_iam_access_key.turbot_firehose_user_access_key.secret
  account_id        = data.aws_caller_identity.current_identity.account_id
  function_name     = var.enabled_caching ? aws_lambda_function.lambda_function_for_cache[0].function_name : aws_lambda_function.lambda_function_no_cache[0].function_name
  function_arn      = var.enabled_caching ? aws_lambda_function.lambda_function_for_cache[0].arn : aws_lambda_function.lambda_function_no_cache[0].arn
  environment_variables = var.enabled_caching ? {
    SECURITY_HUB_PRODUCT_ARN         = "arn:aws:securityhub:${var.aws_region}:${local.account_id}:product/${local.account_id}/default"
    MEMCACHED_CONFIGURATION_ENDPOINT = aws_elasticache_cluster.latest_notification_cache[0].configuration_endpoint
  } : { SECURITY_HUB_PRODUCT_ARN = "arn:aws:securityhub:${var.aws_region}:${local.account_id}:product/${local.account_id}/default" }
}
