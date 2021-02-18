resource "null_resource" "create_package" {
  # Get notified on all the actions taken by Turbot for the resources at Turbot Root level and its descendant, which have turbot.tag as `Environment:Development`.
  provisioner "local-exec" {
    command = "./package-lambda.sh"
  }
}

resource "aws_lambda_function" "lambda_function" {
  depends_on = [
    null_resource.create_package
  ]
  role             = aws_iam_role.turbot_firehose_lamdba_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.7"
  filename         = "deployment-package.zip"
  function_name    = "turbot-firehose-to-sec-hub-write-to-security-hub"
  source_code_hash = base64sha256("deployment-package.zip")
  description      = "Transform notifications from Turbot to finding for SecurityHub"
  timeout          = 30

  vpc_config {
    # Every subnet should be able to reach an EFS mount target in the same Availability Zone. Cross-AZ mounts are not permitted.
    subnet_ids         = [local.create_vpc ? aws_subnet.private_subnet[0].id : data.aws_subnet.private_subnet[0].id]
    security_group_ids = [local.security_group_id]
  }

  environment {
    variables = local.environment_variables
  }

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
  }
}

resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn                   = aws_sqs_queue.turbot_firehose_notification_queue.arn
  function_name                      = aws_lambda_function.lambda_function.arn
  maximum_batching_window_in_seconds = var.batch_window
  batch_size                         = var.batch_size
}
