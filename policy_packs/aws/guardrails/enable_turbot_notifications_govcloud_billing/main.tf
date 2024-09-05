resource "turbot_policy_pack" "main" {
  akas        = ["aws_guardrails_enable_turbot_notifications_govcloud_billing"]
  title       = "Enable Turbot Notifications for Gov Cloud Billing in Guardrails"
  description = "This policy pack ensures proactive budget management by sending real-time Turbot notifications when the set budget threshold is reached for a GovCloud account."
}
