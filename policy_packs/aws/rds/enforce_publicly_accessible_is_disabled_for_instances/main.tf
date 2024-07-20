resource "turbot_policy_pack" "main" {
  title       = "Enforce Publicly Accessible Is Disabled for Instances"
  description = "Ensure that RDS instances are not publicly accessible to enhance security by restricting access."
  akas        = ["aws_rds_enforce_publicly_accessible_is_disabled_for_instances"]
}
