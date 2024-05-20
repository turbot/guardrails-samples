resource "turbot_smart_folder" "vpc_restrict_igw" {
  title         = var.smart_folder_title
  description   = "Create a smart folder with policies that restrict IGW usage"
  parent        = "tmod:@turbot/turbot#/"
}

# Setting IGW Policies
# AWS > VPC > Internet Gateway > Approved

resource "turbot_policy_setting" "vpc_igw_approved" {
    resource = turbot_smart_folder.vpc_restrict_igw.id
    type = "tmod:@turbot/aws-vpc-internet#/policy/types/internetGatewayApproved"
    value = "Check: Approved"
}

# Setting IGW Policies
# AWS > VPC > Internet Gateway > Approved > Usage

resource "turbot_policy_setting" "vpc_igw_approved_usage" {
    resource = turbot_smart_folder.vpc_restrict_igw.id
    type = "tmod:@turbot/aws-vpc-internet#/policy/types/internetGatewayApprovedUsage"
    value = "Not approved"
}