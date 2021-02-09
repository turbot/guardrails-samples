# Subnets should not allow automatic public IP assignment

# AWS > VPC > Subnet > Approved
# https://turbot.com/v5/mods/turbot/aws-vpc-core/inspect#/policy/types/subnetApproved
resource "turbot_policy_setting" "aws_vpc_subnet_approved" {
  count    = var.enable_aws_vpc_subnet_approved ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/subnetApproved"
  value    = "Check: Approved"
}


# AWS > VPC > Subnet > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-vpc-core/inspect#/policy/types/subnetApprovedUsage
resource "turbot_policy_setting" "aws_vpc_subnet_approved_usage" {
  count    = var.enable_aws_vpc_subnet_approved_usage ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/subnetApprovedUsage"
  # GraphQL to pull resource metadata
  template_input = <<-QUERY
        {
            resource {
                publicIp: get(path: "MapPublicIpOnLaunch")
            }
        }
        QUERY

  # Nunjucks template evaluate metadata.
  template = <<-TEMPLATE
        {%- if $.resource.publicIp -%}
            Not approved
        {%- else -%}
            Approved
        {%- endif -%}
        TEMPLATE
}
