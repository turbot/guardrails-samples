# AWS > EC2 > Snapshot > Active
resource "turbot_policy_setting" "aws_ec2_snapshot_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/snapshotActive"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 7 days warning"
}

# AWS > EC2 > Snapshot > Active > Age
resource "turbot_policy_setting" "aws_ec2_snapshot_active_age" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/snapshotActiveAge"
  value    = "Force inactive if age > 60 days"
}
