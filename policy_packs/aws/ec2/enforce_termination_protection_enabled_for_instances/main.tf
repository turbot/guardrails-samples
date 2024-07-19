resource "turbot_policy_pack" "main" {
  title       = "Enforce Termination Protection Enabled For AWS EC2 Instances"
  description = "Prevents accidental or unauthorized termination of instances, which can lead to data loss, application downtime, and potential security vulnerabilities"
  akas        = ["aws_ec2_enforce_termination_protection_enabled_for_instances"]
}
