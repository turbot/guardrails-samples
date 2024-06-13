terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
}

resource "turbot_smart_folder" "pack" {
  title       = "Enforce IMDSv2 on AWS EC2 Instances"
  description = "Ensure that IMDSv2 is enforced for AWS EC2 instances."
  parent      = "tmod:@turbot/turbot#/"
}

# Common policies

resource "turbot_policy_setting" "aws_ec2_enabled" {
  resource = turbot_smart_folder.pack.id
  # AWS > EC2 > Enabled
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2Enabled"
  value    = "Enabled"
}

# Primary policies

resource "turbot_policy_setting" "aws_ec2_instance_metadata_service" {
  resource = turbot_smart_folder.pack.id
  # AWS > EC2 > Instance > Metadata Service
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceMetadataService"
  value    = "Check: Enabled for V2 only"
  # value =  "Check: Enabled for V1 and V2"
  # value =  "Enforce: Enabled for V1 and V2"
  # value =  "Enforce: Enabled for V2 only"
}

resource "turbot_policy_setting" "aws_ec2_instance_metadata_service_token_hop_limit" {
  resource = turbot_smart_folder.pack.id
  # AWS > EC2 > Instance > Metadata Service > HTTP Token Hop Limit
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceMetadataServiceTokenHopLimit"
  # Set HTTP Token Hop Limit between 1 and 64
  value    = 1
}
