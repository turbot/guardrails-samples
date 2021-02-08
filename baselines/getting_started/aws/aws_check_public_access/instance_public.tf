# Check for Public EC2 Instances and Metadata Service Security

# EC2 Instance Elastic IP assignment
# AWS > EC2 > Instance > Approved > Public IP
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/instanceApprovedPublicIp
resource "turbot_policy_setting" "aws_ec2_instance_approved_public_ip" {
  count    = var.enable_aws_ec2_instance_approved_public_ip ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedPublicIp"
  value    = "Approved if not assigned"
}

# EC2 Metadata security best practices is to enable v2 for session based authentication
# AWS > EC2 > Instance > Metadata Service
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/instanceMetadataService
resource "turbot_policy_setting" "aws_ec2_instance_metadata_service" {
  count    = var.enable_aws_ec2_instance_metadata_service ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceMetadataService"
  value    = "Check: Enabled for V2 only"
}

# EC2 Metadata security best practices.
# 1 Hop limit ensures the packet is dropped leaving the EC2 instance
# AWS > EC2 > Instance > Metadata Service > HTTP Token Hop Limit
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/instanceMetadataServiceTokenHopLimit
resource "turbot_policy_setting" "aws_ec2_instance_metadata_service_token_hop_limit" {
  count    = var.enable_aws_ec2_instance_metadata_service_token_hop_limit ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceMetadataServiceTokenHopLimit"
  value    = "1"
}
