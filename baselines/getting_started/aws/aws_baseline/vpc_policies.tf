# Set misc defaults common for a Turbot Workspace

# Delete Default VPCs
# AWS > VPC > Default VPC > Approved
# https://turbot.com/v5/mods/turbot/aws-vpc-core/inspect#/policy/types/defaultVpcApproved
resource "turbot_policy_setting" "defaultVpcApproved" {
  resource = turbot_smart_folder.aws_baseline.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/defaultVpcApproved"
  value    = "Check: Approved"
}

# AWS > VPC > Default VPC > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-vpc-core/inspect#/policy/types/defaultVpcApprovedUsage
resource "turbot_policy_setting" "defaultVpcApprovedUsage" {
  resource = turbot_smart_folder.aws_baseline.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/defaultVpcApprovedUsage"
  value    = "Not approved"
}
