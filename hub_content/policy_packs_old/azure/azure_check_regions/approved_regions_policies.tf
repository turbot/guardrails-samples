# Approved Regions cloud resources are allowed to reside in. Starting with eastus and eastus2

# Azure > Subscription > Approved Regions [Default
# https://turbot.com/v5/mods/turbot/azure/inspect#/policy/types/approvedRegionsDefault
resource "turbot_policy_setting" "azure_approved_regions" {
  resource = turbot_smart_folder.azure_regions.id
  type     = "tmod:@turbot/azure#/policy/types/approvedRegionsDefault"
  value    = <<-ALLOWEDREGIONS
    ${yamlencode([for region in var.resource_approved_regions_region_list : region])}
  ALLOWEDREGIONS
}

# Azure > Subscription > Regions [Default]
# https://turbot.com/v5/mods/turbot/azure/inspect#/policy/types/regionsDefault
## Sets approved region policy for each resource type in the resource_approved_regions map.
resource "turbot_policy_setting" "set_resource_approved_regions_policies" {
  for_each = var.resource_approved_regions
  resource = turbot_smart_folder.azure_regions.id
  type     = local.policy_map[each.key]
  value    = each.value
}
