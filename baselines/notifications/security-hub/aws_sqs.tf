resource "aws_sqs_queue" "turbot_firehose_notification_queue" {
  name                      = "turbot-firehose-notification-queue"
  message_retention_seconds = 86400
  receive_wait_time_seconds = 20

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
  }
}

resource "aws_sqs_queue_policy" "turbot_firehose_notification_queue_policy" {
  queue_url = aws_sqs_queue.turbot_firehose_notification_queue.id

  policy = <<-POLICY
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "sns.amazonaws.com"
        },
        "Action": "sqs:SendMessage",
        "Resource": "${aws_sqs_queue.turbot_firehose_notification_queue.arn}",
        "Condition": {
          "ArnEquals": {
            "aws:SourceArn": "${aws_sns_topic.turbot_firehose_user_sns_topic.arn}"
          }
        }
      }
    ]
  }
  POLICY
}
