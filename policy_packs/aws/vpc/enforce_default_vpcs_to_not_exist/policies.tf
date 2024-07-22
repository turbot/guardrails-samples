# AWS > VPC > Default VPC > Approved
resource "turbot_policy_setting" "aws_vpc_default_vpc_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/defaultVpcApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Force delete unapproved"
}

# AWS > VPC > Default VPC > Approved > Usage
resource "turbot_policy_setting" "aws_vpc_default_vpc_approved_usage" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/defaultVpcApprovedUsage"
  value    = "Not approved"
}
