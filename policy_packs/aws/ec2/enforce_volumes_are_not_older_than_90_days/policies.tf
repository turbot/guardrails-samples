# AWS > EC2 > Volume > Active
resource "turbot_policy_setting" "aws_ec2_volume_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeActive"
  value    = "Check: Active"
  # value    = "Enforce: Detach, snapshot and delete inactive with 7 days warning"
}

# AWS > EC2 > Volume > Active > Age
resource "turbot_policy_setting" "aws_ec2_volume_active_age" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeActiveAge"
  value    = "Force inactive if age > 90 days"
}
