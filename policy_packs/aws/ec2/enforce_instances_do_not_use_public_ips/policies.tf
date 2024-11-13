# AWS > EC2 > Instance > Approved > Public IP
resource "turbot_policy_setting" "aws_ec2_instance_approved_public_ip" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedPublicIp"
  value    = "Check: Not public"
  # value    = "Enforce: Stop if public"
  # value    = "Enforce: Stop if public and new"
  # value    = "Enforce: Delete if public and new"
}
