resource "aws_sns_topic" "turbot_firehose_user_sns_topic" {
  name         = "turbot_firehose_user_sns_topic"
  display_name = "Turbot to Security Hub"
  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
  }
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.turbot_firehose_user_sns_topic.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.turbot_firehose_user_sns_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.turbot_firehose_notification_queue.arn
}
