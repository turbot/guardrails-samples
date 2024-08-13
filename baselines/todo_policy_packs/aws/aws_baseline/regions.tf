# Limiting Turbot Event Handlers to specific regions. Default to us-east-1 only
# More Info: https://turbot.com/v5/docs/guides/regions#discovering-regions

# Limit Available Regions
# "*" allows Turbot to run in all available regions.
# Other wildcarding is allowed e.g. us*, us-east-*
# Remove the comment next to the region to include additional regions to the scope  
# Note: us-east-1 is required since it is an AWS global region for specific services

# https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/regionsDefault
resource "turbot_policy_setting" "aws_account_available_regions" {
  count    = length(var.aws_account_default_regions) > 0 ? 1 : 0
  resource = turbot_smart_folder.aws_baseline.id
  type     = "tmod:@turbot/aws#/policy/types/regionsDefault"
  value    = <<-DEFAULTREGIONS
    ${yamlencode([for region in var.aws_account_default_regions : region])}
  DEFAULTREGIONS
}
