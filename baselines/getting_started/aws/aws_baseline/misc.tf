# Set misc defaults common for a Turbot Workspace

#Delete Default VPCs
resource "turbot_policy_setting" "defaultVpcApproved" {
  resource = turbot_smart_folder.aws_baseline.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/defaultVpcApproved"
  value    = "Check: Approved"
}

resource "turbot_policy_setting" "defaultVpcApprovedUsage" {
  resource = turbot_smart_folder.aws_baseline.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/defaultVpcApprovedUsage"
  value    = "Not approved"
}
