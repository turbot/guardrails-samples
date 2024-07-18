# AWS > EC2 > Instance > Active
resource "turbot_policy_setting" "aws_ec2_instance_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceActive"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 7 days warning"
}

# AWS > EC2 > Instance > Active > Age
resource "turbot_policy_setting" "aws_ec2_instance_active_age" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceActiveAge"
  value    = "Force inactive if age > 90 days"
}
