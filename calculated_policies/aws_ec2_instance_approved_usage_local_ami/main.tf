resource "turbot_smart_folder" "aws_ec2_instance_approved_usage_local_ami" {
  title       = var.smart_folder_title
  description = "Restrict AWS EC2 Instance to local images"
  parent      = "tmod:@turbot/turbot#/"
}

resource "turbot_smart_folder_attachment" "aws_ec2_instance_approved_usage_local_ami" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.aws_ec2_instance_approved_usage_local_ami.id
}

# AWS > EC2 > Instance > Approved
resource "turbot_policy_setting" "aws_ec2_instance_approved_local_ami" {
  resource = turbot_smart_folder.aws_ec2_instance_approved_usage_local_ami.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
  value    = "Check: Approved"
}

# AWS > EC2 > Instance > Approved > Usage
resource "turbot_policy_setting" "aws_ec2_instance_approved_usage_local_ami" {
  resource = turbot_smart_folder.aws_ec2_instance_approved_usage_local_ami.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedUsage"
  # GraphQL to pull function metadata
  template_input = <<EOT
  - |
    {
      item: resource {
        imageId: get(path: "ImageId")
        turbot {
          custom
        }
      }
    }
  - |
    {
      resources (filter: "resourceType:'tmod:@turbot/aws-ec2#/resource/types/Ami' $.ImageId:'{{$.item.imageId}}' $.OwnerId:'{{$.item.turbot.custom.aws.accountId}}'") {
        metadata {
          stats {
            total
          }
        }
      }
    }
  EOT
  # Nunjucks Template Nunjucks Comments are formatted: {# comment #}
  template = <<EOT
  {% if $.resources.metadata.stats.total %}
    "Approved"
  {% else %}
    "Not approved"
  {% endif %}
  EOT
}
