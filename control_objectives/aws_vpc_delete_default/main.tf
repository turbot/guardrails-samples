# Smart Folder Definition
resource "turbot_smart_folder" "aws_default_vpc_deletion" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# Below examples assume starting in Check mode to identify the impact.
# Can use the commented values to replace the template.
# Edit the template below to meet your requirements.

# Delete Default VPCs
# AWS > VPC > Default VPC > Approved
# https://turbot.com/v5/mods/turbot/aws-vpc-core/inspect#/policy/types/defaultVpcApproved
resource "turbot_policy_setting" "defaultVpcApproved" {
  resource = turbot_smart_folder.aws_default_vpc_deletion.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/defaultVpcApproved"
  value    = "Check: Approved"
            # Skip
            # Check: Approved
            # Enforce: Force delete unapproved
}

# AWS > VPC > Default VPC > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-vpc-core/inspect#/policy/types/defaultVpcApprovedUsage
resource "turbot_policy_setting" "defaultVpcApprovedUsage" {
  resource = turbot_smart_folder.aws_default_vpc_deletion.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/defaultVpcApprovedUsage"
  value    = "Not approved"
            # Not approved
            # Approved
            # Approved if AWS > VPC > Enabled
}