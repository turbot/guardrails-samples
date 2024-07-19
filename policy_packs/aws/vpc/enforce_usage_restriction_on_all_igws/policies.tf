# AWS > VPC > Internet Gateway > Approved
resource "turbot_policy_setting" "vpc_igw_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/internetGatewayApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Detach unapproved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > VPC > Internet Gateway > Approved > Usage
resource "turbot_policy_setting" "vpc_igw_approved_usage" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/internetGatewayApprovedUsage"
  value    = "Not approved"
}