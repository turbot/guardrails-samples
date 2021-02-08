# Check Public Route53 Hosted Zone. Check for VPC Configurations
# Commented out since these services are not associated to the initial mod install list

# Check on Route53 Hosted Zone that is not internal by evaluating VPC Configurations

# AWS > Route 53 > Hosted Zone > Approved
# https://turbot.com/v5/mods/turbot/aws-route53/inspect#/policy/types/hostedZoneApproved
resource "turbot_policy_setting" "aws_route53_hostedzone_approved" {
  count    = var.enable_aws_route53_hostedzone_approved ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-route53#/policy/types/hostedZoneApproved"
  value    = "Check: Approved"
  #value   = "Enforce: Delete unapproved if new"
}


# AWS > Route 53 > Hosted Zone > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-route53/inspect#/policy/types/hostedZoneApprovedUsage
resource "turbot_policy_setting" "aws_route53_hostedzone_approved_usage" {
  count    = var.enable_aws_route53_hostedzone_approved_usage ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-route53#/policy/types/hostedZoneApprovedUsage"
  # GraphQL to pull VPC info on the hosted zone
  template_input = <<-QUERY
    {
    hostedZone {
        VPCs {
        VPCId
        }
     }
    }
    QUERY
  # Nunjucks template
  template = <<-TEMPLATE
    {%- if $.hostedZone.VPCs.VPCId == null -%}
    "Approved"
    {%- else -%}
    "Not approved"
    {%- endif -%}
    TEMPLATE
}
