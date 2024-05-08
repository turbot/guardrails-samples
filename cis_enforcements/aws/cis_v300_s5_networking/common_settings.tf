resource "turbot_smart_folder" "aws_cis_v300_s5_networking" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "AWS CIS v3.0.0 - Section 5 - Networking"
  description = "This section contains recommendations for configuring security-related aspects of AWS Virtual Private Cloud (VPC)."
}

# AWS > EC2 > Enabled
resource "turbot_policy_setting" "aws_ec2_enabled" {
  resource = turbot_smart_folder.aws_cis_v300_s5_networking.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2Enabled"
  value    = "Enabled"
}

# AWS > VPC > Enabled
resource "turbot_policy_setting" "aws_vpc_enabled" {
  resource = turbot_smart_folder.aws_cis_v300_s5_networking.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcServiceEnabled"
  value    = "Enabled"
}
