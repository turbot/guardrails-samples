resource "aws_sqs_queue" "turbot_firehose_notification_queue" {
  name                      = "turbot-firehose-notification-queue"
  message_retention_seconds = 86400
  receive_wait_time_seconds = 20
  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
  }
}
