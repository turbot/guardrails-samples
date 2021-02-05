# Application Load Balancer (ALB) Access Logging Check
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/applicationLoadBalancerAccessLogging
resource "turbot_policy_setting" "aws_alb_access_logging" {
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/applicationLoadBalancerAccessLogging"
  value    = "Check: Enabled"
}

# Classic Load Balancer (ELB) Access Logging Check
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/classicLoadBalancerAccessLogging
resource "turbot_policy_setting" "aws_elb_access_logging" {
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/classicLoadBalancerAccessLogging"
  value    = "Check: Enabled"
}

# Network Load Balancer (NLB) Access Logging Check
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/networkLoadBalancerAccessLogging
resource "turbot_policy_setting" "aws_nlb_access_logging" {
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/networkLoadBalancerAccessLogging"
  value    = "Check: Enabled"
}