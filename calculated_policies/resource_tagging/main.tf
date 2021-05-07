# Smart Folder Definition
resource "turbot_smart_folder" "resource_details_tagging" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > EC2 > Instance > Tags
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/instanceTags

resource "turbot_policy_setting" "aws_ec2_instance_tags" {
  resource = "turbot_smart_folder.resource_details_tagging.id"
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceTags"
  value    = "Check: Tags are correct"
            # "Skip"
            # "Check: Tags are correct"
            # "Encorce: Set tags"
}


# AWS > EC2 > Instance > Tags > Template
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/instanceTagsTemplate

resource "turbot_policy_setting" "aws_ec2_instance_tags_template" {
  resource = "turbot_smart_folder.resource_details_tagging.id"
  type           = "tmod:@turbot/aws-ec2#/policy/types/instanceTagsTemplate"
  template_input = <<EOT
  {
    instance {
    ImageId
      InstanceId
      InstanceType
      PrivateIpAddress
      SubnetId
      VpcId
    }
  }
  EOT
    template       = <<EOT
  "Instance ID": "{{ $.instance.InstanceId }}"
  Type: "{{ $.instance.InstanceType }}"
  Image: "{{ $.instance.ImageId }}"
  VPC: "{{ $.instance.VpcId }}"
  Subnet: "{{ $.instance.SubnetId }}"
  "IP Address": "{{ $.instance.PrivateIpAddress }}"
  EOT
}