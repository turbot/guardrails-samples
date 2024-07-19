# AWS > VPC > NAT Gateway > Approved
resource "turbot_policy_setting" "vpc_nat_gateway_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/natGatewayApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > VPC > NAT Gateway > Approved > Usage
resource "turbot_policy_setting" "vpc_nat_gateway_approved_usage" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/natGatewayApprovedUsage"
  value    = "Not approved"
}