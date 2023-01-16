
terraform {
  required_providers {
    turbot = {
      source = "terraform-providers/turbot"
    }
  }
  required_version = ">= 0.13"
}

# Smart Folder Definition
resource "turbot_smart_folder" "gcp_computeengine_image" {
  title          = var.smart_folder_title
  description    = var.smart_folder_description
  parent         = var.smart_folder_parent_resource
}

# AWS > VPC > VPC > Approved
resource "turbot_policy_setting" "gcp_computeengine_image_approved" {
  resource       = turbot_smart_folder.gcp_computeengine_image.id
  type           = "tmod:@turbot/gcp-computeengine#/policy/types/imageApproved"
  value          = "Check: Approved"
}

resource "turbot_policy_setting" "gcp_computeengine_image_approved_usage" {
  resource       = turbot_smart_folder.gcp_computeengine_image.id
  type           = "tmod:@turbot/gcp-computeengine#/policy/types/imageApprovedUsage"
  template_input = <<EOT
{
      item: resource {
        name: get(path: "name")
        imageId: get(path: "sourceImage")
      }
}
EOT
  template       = <<EOT
{% if $.item.imageId == null %} 
  "Not approved"
{% else %}
{% set imageName = $.item.name %}
{% set imageProject = $.item.imageId.split("projects/")[1].split("/") | first %}
{% set approvedImageProjectList = [
  'project1',
  'project2'
  ] %}
{% set approvedImageList  = [
  'image1',
  'image2'
  ] %}

{% if imageProject in approvedImageProjectList and imageName in approvedImageList%}
  "Approved"
{% else %}
  "Not approved"  
{% endif %}
{% endif %}
EOT
}
