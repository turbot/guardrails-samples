# No IGWs should exist in the account, unless approved for use

# AWS > VPC > Internet Gateway > Approved
# https://turbot.com/v5/mods/turbot/aws-vpc-internet/inspect#/policy/types/internetGatewayApproved
resource "turbot_policy_setting" "aws_vpc_igw_approved" {
  count    = var.enable_aws_vpc_igw_approved ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/internetGatewayApproved"
  value    = "Check: Approved"
  # value           = "Enforce: Detach and delete unapproved if new"
}

# AWS > VPC > Internet Gateway > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-vpc-internet/inspect#/policy/types/internetGatewayApprovedUsage
resource "turbot_policy_setting" "aws_vpc_igw_approved_usage" {
  count    = var.enable_aws_vpc_igw_approved_usage ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/internetGatewayApprovedUsage"
  value    = "Not approved"
}
