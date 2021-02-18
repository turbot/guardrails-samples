# Approved Regions cloud resources are allowed to reside in. Starting with us regions and global
# GCP > Project > Approved Regions [Default]P
# https://turbot.com/v5/mods/turbot/gcp/inspect#/policy/types/approvedRegionsDefault
resource "turbot_policy_setting" "gcp_project_approved_regions" {
  resource        = turbot_smart_folder.gcp_regions.id
  type            = "tmod:@turbot/gcp#/policy/types/approvedRegionsDefault"
  value           = <<-ALLOWEDREGIONS
    # - asia-east1
    # - asia-east2
    # - asia-northeast1
    # - asia-northeast2
    # - asia-northeast3
    # - asia-south1
    # - asia-southeast1
    # - australia-southeast1
    # - europe-north1
    # - europe-west1
    # - europe-west2
    # - europe-west3
    # - europe-west4
    # - europe-west6
    # - northamerica-northeast1
    # - southamerica-east1
      - us-central1
      - us-east1
      - us-east4
      - us-west1
      - us-west2
      - us-west3
    # - asia
    # - eu
    # - eur3
    # - eur4
    # - nam-eur-asia1
    # - nam3
    # - nam4
    # - nam5
    # - nam6
      - us
      - global
    ALLOWEDREGIONS
}

## Sets approved region policy for each resource type in the resource_approved_regions map.
resource "turbot_policy_setting" "set_resource_approved_regions_policies" {
  for_each = var.resource_approved_regions
  resource = turbot_smart_folder.gcp_regions.id
  type     = local.policy_map[each.key]
  value    = each.value
}