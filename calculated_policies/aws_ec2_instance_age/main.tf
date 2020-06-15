# Smart Folder Definition
resource "turbot_smart_folder" "ec2_instance_age" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > EC2 > Instance > Active
resource "turbot_policy_setting" "instance_active" {
  resource = turbot_smart_folder.ec2_instance_age.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceActive"
  value    = "Enforce: Delete inactive with 7 days warning"
}

# AWS > EC2 > Instance > Active > Age
resource "turbot_policy_setting" "instance_age" {
  resource = turbot_smart_folder.ec2_instance_age.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceActiveAge"
  # GraphQL to pull instance tags
  template_input = <<EOT
{
  instance {
    turbot {
      tags
    }
  }
}
  EOT

  # Nunjucks Template
  template = <<EOT
{% if $.instance.turbot.tags.Environment == "Lab" %}
  "Force inactive if age > 30 days"
{% else %}
  "Skip"
{% endif %}
  EOT
}
