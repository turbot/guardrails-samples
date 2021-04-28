#Smart folder
resource "turbot_smart_folder" "aws_ami_tag" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}