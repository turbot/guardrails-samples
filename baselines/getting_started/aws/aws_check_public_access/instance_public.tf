# Check for Public EC2 Instances and Metadata Service Security

# EC2 Instance Elastic IP assignment
resource "turbot_policy_setting" "aws_ec2_instance_approved_public_ip" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedPublicIp"
  value    = "Approved if not assigned"
}

# EC2 Metadata security best practices is to enable v2 for session based authentication
resource "turbot_policy_setting" "aws_ec2_instance_metadata_service" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceMetadataService"
  value    = "Check: Enabled for V2 only"
}

# EC2 Metadata security best practices.
# 1 Hop limit ensures the packet is dropped leaving the EC2 instance 
resource "turbot_policy_setting" "aws_ec2_instance_metadata_service_token_hop_limit" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceMetadataServiceTokenHopLimit"
  value    = "1"
}