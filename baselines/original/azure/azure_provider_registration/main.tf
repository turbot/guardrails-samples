resource "turbot_smart_folder" "azure_folder" {
  parent      = var.folder_parent
  title       = var.smart_folder_title
  description = "Folder to import the Azure Subscription:"
}

resource "turbot_smart_folder_attachment" "azure_folder" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.azure_folder.id
}

resource "turbot_policy_setting" "provider_registration_enable" {
  count    = length(var.provider_status)
  resource = turbot_smart_folder.azure_folder.id
  type     = "tmod:@turbot/azure-provider#/policy/types/${lookup(var.provider_registration_map, "${element(keys(var.provider_status), count.index)}")}"
  value    = lookup(var.provider_status, "${element(keys(var.provider_status), count.index)}")
}
