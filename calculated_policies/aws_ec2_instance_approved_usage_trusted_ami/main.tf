# Smart Folder Definition
resource "turbot_smart_folder" "aws_ec2_instance_approved_usage_trusted_ami" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > EC2 > Instance > Approved
resource "turbot_policy_setting" "aws_ec2_instance_approved_trusted_ami" {
  resource = turbot_smart_folder.aws_ec2_instance_approved_usage_trusted_ami.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
  value    = "Check: Approved"
}

# AWS > EC2 > Instance > Approved > Usage
resource "turbot_policy_setting" "aws_ec2_instance_approved_usage_trusted_ami" {
  resource = turbot_smart_folder.aws_ec2_instance_approved_usage_trusted_ami.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedUsage"
  # GraphQL to pull function metadata
  template_input = <<EOT
  {
    resource {
      imageId: get(path: "ImageId")
    }
  }
  EOT
  # Nunjucks Template Nunjucks Comments are formatted: {# comment #}
  template = <<EOT
  {% set approvedImageIds = [
      "${join("\",\n      \"", var.trusted_ami_list)}"
    ]
  %}
  {% if $.resource.imageId in approvedImageIds %}
    "Approved"
  {% else %}
    "Not approved"
  {% endif %}
  EOT
}

# Attach Smart Folder
resource "turbot_smart_folder_attachment" "aws_ec2_instance_approved_usage_trusted_ami" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.aws_ec2_instance_approved_usage_trusted_ami.id
}
