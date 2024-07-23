# Create smart folder
resource "turbot_smart_folder" "vpc_restrict_nat" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to apply the s3 policy settings"
  parent        = "tmod:@turbot/turbot#/"
}

# Setting NAT Usage Policies. This can also be set to `Enforce: Delete unapproved if new`
# AWS > VPC > NAT Gateway > Approved
resource "turbot_policy_setting" "vpc_natgw_approved" {
    resource = turbot_smart_folder.vpc_restrict_nat.id
    type = "tmod:@turbot/aws-vpc-internet#/policy/types/natGatewayApproved"
    value = "Check: Approved"
}

# Set approval check to not approved.
# AWS > VPC > NAT Gateway > Approved > Usage
resource "turbot_policy_setting" "vpc_natgw_approved_usage" {
    resource = turbot_smart_folder.vpc_restrict_nat.id
    type = "tmod:@turbot/aws-vpc-internet#/policy/types/natGatewayApprovedUsage"
    value = "Not approved"
}