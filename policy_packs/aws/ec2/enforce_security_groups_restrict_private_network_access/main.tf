resource "turbot_policy_pack" "main" {
  title       = "AWS EC2 Enforce Security Groups Restrict Private Network Access"
  description = "Enforce that AWS EC2 Security Groups do not allow access to a wide private network."
  akas        = ["aws_ec2_enforce_security_groups_restrict_private_network_access"]
}
