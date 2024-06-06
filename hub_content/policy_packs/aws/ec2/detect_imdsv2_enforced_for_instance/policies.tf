# AWS > EC2 > Instance > Metadata Service
resource "turbot_policy_setting" "aws_ec2_instance_metadata_service" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceMetadataService"
  value    = "Check: Enabled for V2 only"
  # value =  "Check: Disabled"
  # value =  "Check: Enabled for V1 and V2"
  # value =  "Enforce: Disabled"
  # value =  "Enforce: Enabled for V1 and V2"
  # value =  "Enforce: Enabled for V2 only"
}

# AWS > EC2 > Instance > Metadata Service > HTTP Token Hop Limit
resource "turbot_policy_setting" "aws_ec2_instance_metadata_service_token_hop_limit" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceMetadataServiceTokenHopLimit"
  value    = 1
}
