# Commented out as the initial baseline assumes event polling vs event handlers in each region.
# If using Turbot Event Handlers, this baseline would be relevant if reducing Turbot Event Handlers to specific regions only
# Default to us and global regions only
# More Info: https://turbot.com/v5/docs/guides/regions#discovering-regions

# Limit Available Regions
# "*" allows Turbot to run in all available regions.
# Other wildcarding is allowed e.g. us*, us-east-*
# Remove the comment next to the region to include additional regions to the scope  
# Note: global is required since the global region is used for specific services


#resource "turbot_policy_setting" "gcp_project_available_regions" {
#  resource        = turbot_smart_folder.gcp_baseline.id
#  type            = "tmod:@turbot/gcp#/policy/types/RegionsDefault"
#  value           = <<-REGIONS
#    # - asia-east1
#    # - asia-east2
#    # - asia-northeast1
#    # - asia-northeast2
#    # - asia-northeast3
#    # - asia-south1
#    # - asia-southeast1
#    # - australia-southeast1
#    # - europe-north1
#    # - europe-west1
#    # - europe-west2
#    # - europe-west3
#    # - europe-west4
#    # - europe-west6
#    # - northamerica-northeast1
#    # - southamerica-east1
#      - us-central1
#      - us-east1
#      - us-east4
#      - us-west1
#      - us-west2
#      - us-west3
#    # - asia
#    # - eu
#    # - eur3
#    # - eur4
#    # - nam-eur-asia1
#    # - nam3
#    # - nam4
#    # - nam5
#    # - nam6
#      - us
#      - global
#    REGIONS
#}

