locals {
  access_key        = aws_iam_access_key.turbot_firehose_user_access_key.id
  secret_access_key = aws_iam_access_key.turbot_firehose_user_access_key.secret
  account_id        = data.aws_caller_identity.current_identity.account_id
  function_name     = aws_lambda_function.lambda_function.function_name
  vpc               = var.vpc_id == "" ? aws_vpc.main_vpc[0] : data.aws_vpc.main_vpc[0]
  subnet_id         = var.vpc_id == "" ? aws_subnet.main_vpc[0].id : data.aws_subnet.main_vpc[0].id
  security_group_id = var.vpc_id == "" ? aws_default_security_group.allow_memcached_to_lambda[0].id : aws_security_group.allow_memcached_to_lambda[0].id
  create_vpc        = var.enabled_caching && var.vpc_id == "" && var.subnet_id == "" ? 1 : 0
}
