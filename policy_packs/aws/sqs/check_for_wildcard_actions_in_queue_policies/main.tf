resource "turbot_policy_pack" "main" {
  title       = "Check for Wildcard Actions in SQS Queue Policies"
  description = "Ensure that SQS queue policies do not contain 'Action: SQS:*' to enhance security by restricting overly permissive actions."
  akas        = ["aws_sqs_check_for_wildcard_actions_in_queue_policies"]
}