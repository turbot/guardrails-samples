# Smart Folder Definition
resource "turbot_smart_folder" "ec2_volume_unattached" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}


# AWS > EC2 > Volume > Approved
resource "turbot_policy_setting" "aws_ec2_volume_approved" {
  resource = turbot_smart_folder.ec2_volume_unattached.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeApproved"
  value    = <<EOT
'Check: Approved'
EOT
}

# AWS > EC2 > Volume > Active > Age
# We observe that an unattached volume has an empty list for attachments
# An attached volume has > 0 attachments.  The logic below is based on this observation.
resource "turbot_policy_setting" "aws_ec2_volume_approved_usage" {
  resource       = turbot_smart_folder.ec2_volume_unattached.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/volumeApprovedUsage"
  template_input = <<EOT
  {
    resource {
      attachments: get(path: "Attachments")
    }
  }
  EOT
  template       = <<EOT
  {%- if $.resource.attachments | length > 0 -%}
    Approved
  {%- else -%}
    Not Approved
  {%- endif -%}
  EOT
}
