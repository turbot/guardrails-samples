# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Deny VPC security groups with unrestricted internet access"
  description = "Deny VPC security groups with unrestricted internet access"
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > VPC > Enabled
resource "turbot_policy_setting" "aws_vpc_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcServiceEnabled"
  value    = "Enabled"
}
