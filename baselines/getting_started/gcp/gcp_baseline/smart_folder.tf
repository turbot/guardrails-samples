resource "turbot_smart_folder" "aws_all_s3" {
  parent      = var.smart_folder_parent_resource
  title       = var.smart_folder_name
  description = var.smart_folder_description
}

