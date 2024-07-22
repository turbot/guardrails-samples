resource "turbot_policy_pack" "main" {
  title       = "Enable Multi-Region Cloud Trails"
  description = "This measure ensures comprehensive monitoring and auditing of all user activities and API calls across all regions, enhancing security and compliance by providing a complete view of account activity and enabling prompt detection and investigation of unauthorized or anomalous actions."
  akas        = ["aws_guardrails_enable_multi_region_cloud_trails"]
}
