resource "turbot_policy_pack" "main" {
  title       = "AWS EC2 Enforce Security Group Outbound Rules Restrict Protocols"
  description = "Enforce that AWS EC2 Security Group outbound rules do not allow all protocols."
  akas        = ["aws_ec2_enforce_security_groups_outbound_rules_restrict_protocols"]
}
