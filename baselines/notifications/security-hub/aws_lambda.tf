resource "aws_lambda_function" "lambda_function" {
  role             = aws_iam_role.turbot_firehose_lamdba_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.7"
  filename         = "lambda_handler.zip"
  function_name    = "turbot-firehose-write-to-security-hub"
  source_code_hash = base64sha256("lambda_handler.zip")
  description      = "Transform notifications from Turbot to finding for SecurityHub"

  environment {
    variables = {
      SECURITY_HUB_PRODUCT_ARN = "arn:aws:securityhub:${var.aws_region}:${local.account_id}:product/${local.account_id}/default"
    }
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
