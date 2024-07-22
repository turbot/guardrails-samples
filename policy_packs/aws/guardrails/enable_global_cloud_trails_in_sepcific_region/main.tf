resource "turbot_policy_pack" "main" {
  title       = "Enable Global Cloud Trails in Specific Region in Guardrails"
  description = "This setup enhances security by providing a unified trail of events, facilitating efficient incident response and regulatory adherence."
  akas        = ["aws_guardrails_enable_global_cloud_trails_in_sepcific_region"]
}
