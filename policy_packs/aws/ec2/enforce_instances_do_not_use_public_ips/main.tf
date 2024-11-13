resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 Instances Do Not Use Public IPs"
  description = "Ensure that AWS EC2 Instances do not use public IPs. Public IPs can be a security risk and should be avoided where possible."
  akas        = ["aws_ec2_enforce_instances_do_not_use_public_ips"]
}
