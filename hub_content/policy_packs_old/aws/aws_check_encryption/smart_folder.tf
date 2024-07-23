
resource "turbot_smart_folder" "aws_encryption" {
  parent = var.smart_folder_parent_resource
  title  = var.smart_folder_name
  description = var.smart_folder_description
}