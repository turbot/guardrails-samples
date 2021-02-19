resource "null_resource" "create_package" {
  count = var.rebuild ? 1 : 0
  # Get notified on all the actions taken by Turbot for the resources at Turbot Root level and its descendant, which have turbot.tag as `Environment:Development`.
  provisioner "local-exec" {
    command = "./package-lambda.sh"
  }
}

resource "aws_lambda_function" "lambda_function_for_cache" {
  count            = var.enabled_caching ? 1 : 0
  depends_on       = [null_resource.create_package]
  role             = aws_iam_role.turbot_firehose_lamdba_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.7"
  filename         = "deployment-package.zip"
  function_name    = "turbot-firehose-to-sec-hub-write-to-security-hub"
  source_code_hash = base64sha256("deployment-package.zip")
  description      = "Transform notifications from Turbot to finding for SecurityHub"

  vpc_config {
    # Every subnet should be able to reach an EFS mount target in the same Availability Zone. Cross-AZ mounts are not permitted.
    subnet_ids = [aws_subnet.private[0].id]
    security_group_ids = [
      aws_security_group.allow_memcached_to_lambda[0].id,
      aws_security_group.permit_internet[0].id
    ]
  }

  environment {
    variables = local.environment_variables
  }

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
  }
}

resource "aws_lambda_function" "lambda_function_no_cache" {
  count            = var.enabled_caching ? 0 : 1
  depends_on       = [null_resource.create_package]
  role             = aws_iam_role.turbot_firehose_lamdba_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.7"
  filename         = "deployment-package.zip"
  function_name    = "turbot-firehose-to-sec-hub-write-to-security-hub"
  source_code_hash = base64sha256("deployment-package.zip")
  description      = "Transform notifications from Turbot to finding for SecurityHub"

  environment {
    variables = local.environment_variables
  }

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
  }
}

resource "aws_lambda_event_source_mapping" "mapping" {
  event_source_arn                   = aws_sqs_queue.turbot_firehose_notification_queue.arn
  function_name                      = local.function_arn
  maximum_batching_window_in_seconds = var.batch_window
  batch_size                         = var.batch_size
}
