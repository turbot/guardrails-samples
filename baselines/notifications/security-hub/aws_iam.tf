resource "aws_iam_user" "turbot_firehose_user" {
  name = "turbot-firehose-user"
  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
  }
}

resource "aws_iam_user_policy" "turbot_firehose_user_sns_permission" {
  name   = "turbot-firehose-notification-topic-sns-permissions"
  user   = aws_iam_user.turbot_firehose_user.name
  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "sns:Publish",
          "sns:DeleteTopic",
          "sns:CreateTopic",
          "sns:SetTopicAttributes",
          "sns:Subscribe",
          "sns:ConfirmSubscription"
        ],
        "Resource": "${aws_sns_topic.turbot_firehose_user_sns_topic.arn}"
      }
    ]
  }
  EOF
}

resource "aws_iam_role" "turbot_firehose_lamdba_role" {
  name               = "turbot-firehose-lamdba-role"
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  }
  EOF

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
  }
}

resource "aws_iam_role_policy" "turbot_firehose_lamdba_role_sqs_permissions" {
  name = "sqs-permissions"
  role = aws_iam_role.turbot_firehose_lamdba_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "sqs:DeleteMessage",
          "sqs:ReceiveMessage",
          "sqs:GetQueueAttributes"
        ],
        "Resource": "${aws_sqs_queue.turbot_firehose_notification_queue.arn}"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "turbot_firehose_lamdba_role_security_hub_permissions" {
  name = "security-hub-permissions"
  role = aws_iam_role.turbot_firehose_lamdba_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": ["securityhub:GetFindings", "securityhub:BatchUpdateFindings", "securityhub:BatchImportFindings"],
        "Resource": "arn:aws:securityhub:${var.aws_region}:${local.account_id}:product/${local.account_id}/default"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "turbot_firehose_lamdba_role_cloudwatch_permissions" {
  name = "cloudwatch-permissions"
  role = aws_iam_role.turbot_firehose_lamdba_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "logs:CreateLogGroup",
        "Resource": "arn:aws:logs:eu-west-2:210125595713:*"
      },
      {
        "Effect": "Allow",
        "Action": ["logs:CreateLogStream", "logs:PutLogEvents"],
        "Resource": [
          "arn:aws:logs:${var.aws_region}:${local.account_id}:log-group:/aws/lambda/${local.function_name}:*"
        ]
      }
    ]
  }
  EOF
}

resource "aws_iam_access_key" "turbot_firehose_user_access_key" {
  user = aws_iam_user.turbot_firehose_user.name
}

locals {
  account_id    = data.aws_caller_identity.current_identity.account_id
  function_name = aws_lambda_function.lambda_function.function_name
}
