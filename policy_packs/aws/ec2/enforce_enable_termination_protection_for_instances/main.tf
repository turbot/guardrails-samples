resource "turbot_policy_pack" "main" {
  title       = "Enforce Termination Protection Enabled for AWS EC2 Instances"
  description = "Prevent accidental or unauthorized termination of instances, which can lead to data loss, application downtime, and potential security vulnerabilities"
  akas        = ["aws_ec2_enforce_enable_termination_protection_for_instances"]
}
