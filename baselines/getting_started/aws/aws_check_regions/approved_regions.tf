# Approved Regions is a list of AWS regions in which cloud resources are approved for use. 
# Only effective when the AWS > Account > Regions  policies has multiple regions. 
# The regions policy contains a list of AWS regions in which resources can are recorded,

# AWS > Account > Approved Regions [Default]
# https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/approvedRegionsDefault
resource "turbot_policy_setting" "aws_account_approved_regions" {
  resource = turbot_smart_folder.aws_regions.id
  type     = "tmod:@turbot/aws#/policy/types/approvedRegionsDefault"
  value    = <<-ALLOWEDREGIONS
    - us-east-1
    - us-east-2
    # - us-west-1
    # - us-west-2
    # - ap-northeast-1
    # - ap-northeast-2
    # - ap-south-1
    # - ap-southeast-1
    # - ap-southeast-2
    # - ca-central-1
    # - eu-central-1
    # - eu-north-1
    # - eu-west-1
    # - eu-west-2
    # - eu-west-3
    # - sa-east-1
    ALLOWEDREGIONS
}

## Sets approved region policy for each resource type in the resource_approved_regions map.

# AWS > **Service** > **Resource** > Approved
# Example policy: https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/instanceApproved
resource "turbot_policy_setting" "set_resource_approved_regions_policies" {
  for_each = var.resource_approved_regions
  resource = turbot_smart_folder.aws_regions.id
  type     = local.policy_map[each.key]
  value    = each.value
}
