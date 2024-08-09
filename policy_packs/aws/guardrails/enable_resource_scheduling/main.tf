resource "turbot_policy_pack" "main" {
  akas        = ["aws_guardrails_enable_resource_scheduling"]
  title       = "Enable Resource Scheduling in Guardrails"
  description = "Ensure optimal allocation and utilization of resources, thereby preventing overallocation or underutilization."
}
