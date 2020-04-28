resource "turbot_smart_folder" "azure_folder" {
  parent      = var.folder_parent
  title       = var.smart_folder_title
  description = "Folder to import the Azure Subscription:"
}

# Create Event through Event Poller
# Azure > Turbot > Event Poller
resource "turbot_policy_setting" "eventPoller" {
  resource = turbot_smart_folder.azure_folder.id
  type     = "tmod:@turbot/azure#/policy/types/eventPoller"
  value    = "Enabled"
}

# Create Event through Event Handler
# Azure > Turbot > Event Handlers
resource "turbot_policy_setting" "eventHandlers" {
  resource = turbot_smart_folder.azure_folder.id
  type     = "tmod:@turbot/azure#/policy/types/eventHandlers"
  value    = "Enforce: Configured"
}


# Create the Resource Group and set the policy
# Azure > Turbot > Resource Group
resource "turbot_policy_setting" "turbotResourceGroup" {
  resource = turbot_smart_folder.azure_folder.id
  type     = "tmod:@turbot/azure#/policy/types/turbotResourceGroup"
  value    = "Enforce: Configured"
}
