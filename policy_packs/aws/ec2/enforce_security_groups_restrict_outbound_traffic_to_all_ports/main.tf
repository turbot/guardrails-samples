resource "turbot_policy_pack" "main" {
  title       = "AWS EC2 Enforce Security Groups Restrict Outbound Traffic to All Ports"
  description = "Enforce that AWS EC2 Security Groups restrict outbound traffic to all ports."
  akas        = ["aws_ec2_enforce_security_groups_restrict_outbound_traffic_to_all_ports"]
}
