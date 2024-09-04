resource "turbot_policy_pack" "main" {
  akas        = ["aws_guardrails_enable_event_poller"]
  title       = "Enable Event Poller for AWS Accounts"
  description = "The Guardrails Event Poller is an alternative to the Event Handlers, and is a polling mechanism for obtaining relevant events from AWS and updating CMDB."
}
