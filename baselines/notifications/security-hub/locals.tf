locals {
  access_key        = aws_iam_access_key.turbot_firehose_user_access_key.id
  secret_access_key = aws_iam_access_key.turbot_firehose_user_access_key.secret
  account_id        = data.aws_caller_identity.current_identity.account_id
  function_name     = aws_lambda_function.lambda_function.function_name
  create_vpc        = var.public_subnet_id == "" || var.private_subnet_id == "" || var.vpc_id == ""
  vpc_id            = var.enabled_caching ? (local.create_vpc ? aws_vpc.main_vpc[0].id : data.aws_vpc.main_vpc[0].id) : ""
  vpc_cidr_block    = var.enabled_caching ? (local.create_vpc ? aws_vpc.main_vpc[0].cidr_block : data.aws_vpc.main_vpc[0].cidr_block) : ""
  private_subnet_id = var.enabled_caching ? local.create_vpc ? aws_subnet.private_subnet[0].id : data.aws_subnet.private_subnet[0].id : ""
  security_group_id = var.enabled_caching ? local.create_vpc ? aws_default_security_group.allow_memcached_to_lambda[0].id : aws_security_group.allow_memcached_to_lambda[0].id : ""
  environment_variables = var.enabled_caching ? {
    SECURITY_HUB_PRODUCT_ARN         = "arn:aws:securityhub:${var.aws_region}:${local.account_id}:product/${local.account_id}/default"
    MEMCACHED_CONFIGURATION_ENDPOINT = aws_elasticache_cluster.latest_notification_cache[0].configuration_endpoint
  } : { SECURITY_HUB_PRODUCT_ARN = "arn:aws:securityhub:${var.aws_region}:${local.account_id}:product/${local.account_id}/default" }
}
