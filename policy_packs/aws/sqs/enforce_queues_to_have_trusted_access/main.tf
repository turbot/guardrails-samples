resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS SQS Queues To Have Trusted Access"
  description = "Ensure that only authorized entities can interact with your SQS queues, reducing the risk of unauthorized access, message tampering, and potential data breaches, while ensuring compliance with security best practices."
  akas        = ["aws_sqs_enforce_queues_to_have_trusted_access"]
}
