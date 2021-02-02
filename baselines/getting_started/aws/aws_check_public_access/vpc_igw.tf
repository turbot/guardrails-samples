# No IGWs should exist in the account, unless approved for use

# AWS > VPC > Internet Gateway > Approved
resource "turbot_policy_setting" "aws_vpc_igw_approved" {
    resource        = turbot_smart_folder.aws_public_access.id
    type            = "tmod:@turbot/aws-vpc-internet#/policy/types/internetGatewayApproved"
    value           = "Check: Approved"
	# value           = "Enforce: Detach and delete unapproved if new"
}

resource "turbot_policy_setting" "aws_vpc_igw_approved_usage" {
    resource        = turbot_smart_folder.aws_public_access.id
    type            = "tmod:@turbot/aws-vpc-internet#/policy/types/internetGatewayApprovedUsage"
    value           = "Not approved"
}
