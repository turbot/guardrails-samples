# Limiting Turbot Event Handlers to specific regions. Default to us-east-1 only
# More Info: https://turbot.com/v5/docs/guides/regions#discovering-regions

# Limit Available Regions
# "*" allows Turbot to run in all available regions.
# Other wildcarding is allowed e.g. us*, us-east-*
# Remove the comment next to the region to include additional regions to the scope  
# Note: us-east-1 is required since it is an AWS global region for specific services

resource "turbot_policy_setting" "aws_account_available_regions" {
  resource        = turbot_smart_folder.aws_baseline.id
  type            = "tmod:@turbot/aws#/policy/types/regionsDefault"
  value           = <<-REGIONS
    - us-east-1
    # - us-east-2
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
    # - us-gov-east-1
    # - us-gov-west-1
    # - cn-north-1
    # - cn-northwest-1
    REGIONS
}
