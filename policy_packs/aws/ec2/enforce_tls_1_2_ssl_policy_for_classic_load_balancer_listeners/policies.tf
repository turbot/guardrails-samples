# AWS > EC2 > Classic Load Balancer Listener > SSL Policy
resource "turbot_policy_setting" "aws_ec2_classic_load_balancer_listener_ssl_policy" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/classicLoadBalancerListenerSslPolicy"
  value    = "Check: Set in SSL Policy > Allowed"
  # value    = "Enforce: Set to SSL Policy > Default"
}

# AWS > EC2 > Classic Load Balancer Listener > SSL Policy > Default
resource "turbot_policy_setting" "aws_ec2_classic_load_balancer_listener_ssl_policy_default" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/classicLoadBalancerListenerSslPolicyDefault"
  value    = "ELBSecurityPolicy-TLS-1-2-2017-01"
}
