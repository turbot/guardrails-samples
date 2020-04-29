resource "turbot_smart_folder" "azure_folder" {
  parent      = var.folder_parent
  title       = var.smart_folder_title
  description = "Folder to import the Azure Subscription:"
}

resource "turbot_smart_folder_attachment" "azure_folder" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.azure_folder.id
}

resource "turbot_policy_setting" "azure_enable" {
  count    = length(var.service_status)
  resource = turbot_smart_folder.azure_folder.id
  type     = "tmod:@turbot/${element(keys(var.service_status), count.index)}#/policy/types/${lookup(var.policy_map, "${element(keys(var.service_status), count.index)}")}"
  value    = lookup(var.service_status, "${element(keys(var.service_status), count.index)}")
}
