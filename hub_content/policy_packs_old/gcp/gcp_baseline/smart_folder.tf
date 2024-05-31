resource "turbot_smart_folder" "gcp_baseline" {
  parent      = var.smart_folder_parent_resource
  title       = var.smart_folder_name
  description = var.smart_folder_description
}

