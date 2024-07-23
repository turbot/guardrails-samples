# AWS > EC2 > Instance > Termination Protection
resource "turbot_policy_setting" "aws_ec2_instance_termination_protection" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceTerminationProtection"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
