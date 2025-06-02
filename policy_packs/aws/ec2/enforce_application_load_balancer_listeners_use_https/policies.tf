# AWS > EC2 > Load Balancer Listener > Approved
resource "turbot_policy_setting" "aws_ec2_load_balancer_listener_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/loadBalancerListenerApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > EC2 > Load Balancer Listener > Approved > Protocols
resource "turbot_policy_setting" "aws_ec2_load_balancer_listener_approved_protocols_internet_facing" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/loadBalancerListenerApprovedProtocols"
  value    = <<-EOT
    - HTTPS
    EOT
}

# AWS > EC2 > Load Balancer Listener > Approved > Ports
resource "turbot_policy_setting" "aws_ec2_load_balancer_listener_approved_ports" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/loadBalancerListenerApprovedPorts"
  value    = <<-EOT
    - 443
    EOT
}
