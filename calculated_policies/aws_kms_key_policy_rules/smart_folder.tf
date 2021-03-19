resource "turbot_smart_folder" "kms_rules_approved_folder" {
    title           = var.smart_folder_title
    description     = var.smart_folder_description
    parent          = var.smart_folder_parent_resource
}