resource "turbot_smart_folder" "azure_folder" {
  parent      = var.folder_parent
  title       = var.smart_folder_title
  description = "Folder to import the Azure Subscription:"
}

resource "turbot_smart_folder_attachment" "azure_folder" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.azure_folder.id
}

resource "turbot_policy_setting" "cis_policies" {
  count    = length(var.cis_policy_setting)
  resource = turbot_smart_folder.azure_folder.id
  type     = "tmod:@turbot/azure-cisv1#/policy/types/${element(keys(var.cis_policy_setting), count.index)}"
  value    = lookup(var.cis_policy_setting, "${element(keys(var.cis_policy_setting), count.index)}")
}
