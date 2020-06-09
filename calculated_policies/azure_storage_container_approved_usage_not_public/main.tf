resource "turbot_smart_folder" "azure_storage_container_approved_usagenot_public" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

resource "turbot_policy_setting" "azure_storage_container_approved_not_public" {
  resource = turbot_smart_folder.azure_storage_container_approved_usagenot_public.id
  type     = "tmod:@turbot/azure-storage#/policy/types/containerApproved"
  value    = "Check: Approved"
}

resource "turbot_policy_setting" "azure_storage_container_approved_usagenot_public" {
  resource = turbot_smart_folder.azure_storage_container_approved_usagenot_public.id
  type     = "tmod:@turbot/azure-storage#/policy/types/containerApprovedUsage"
  template_input = <<EOT
  {
    resource {
      publicAccess: get(path: "publicAccess")
    }
  }
  EOT
  template = <<EOT
  {%- if $.resource.publicAccess == "None" -%}
    "Approved"
  {%- else -%}
    "Not approved"
  {%- endif -%}
  EOT
}

resource "turbot_smart_folder_attachment" "azure_storage_container_approved_usagenot_public" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.azure_storage_container_approved_usagenot_public.id
}
