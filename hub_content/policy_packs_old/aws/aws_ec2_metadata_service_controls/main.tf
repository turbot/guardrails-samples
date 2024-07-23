# Smart Folder Definition
resource "turbot_smart_folder" "ec2_metadata_service_controls" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# Below examples assume starting in Check mode to identify the impact.
# Edit the template below to meet your requirements.

# EC2 Metadata security best practices is to enable v2 for session based authentication
resource "turbot_policy_setting" "aws_ec2_instance_metadata_service" {
  resource = turbot_smart_folder.ec2_metadata_service_controls.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceMetadataService"
  value    = "Check: Enabled for V2 only"
          # "Skip"
          # "Check: Disabled"
          # "Check: Enabled for V1 and V2"
          # "Check: Enabled for V2 only"
          # "Enforce: Disabled"
          # "Enforce: Enabled for V1 and V2"
          # "Enforce: Enabled for V2 only"
}

# EC2 Metadata security best practices.
# 1 Hop limit ensures the packet is dropped leaving the EC2 instance
# 2 Hop limit would be reccomended in a container environment
# up to 64 is allowed
resource "turbot_policy_setting" "aws_ec2_instance_metadata_service_token_hop_limit" {
  resource = turbot_smart_folder.ec2_metadata_service_controls.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceMetadataServiceTokenHopLimit"
  value    = "1"
}