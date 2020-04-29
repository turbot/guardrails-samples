resource "turbot_smart_folder" "azure_folder" {
  parent      = var.folder_parent
  title       = var.smart_folder_title
  description = "Folder to import the Azure Subscription:"
}

resource "turbot_smart_folder_attachment" "test" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.azure_folder.id
}

# Create Event through Event Poller
# Azure > Turbot > Event Poller
resource "turbot_policy_setting" "eventPoller" {
  resource = turbot_smart_folder.azure_folder.id
  type     = "tmod:@turbot/azure#/policy/types/eventPoller"
  value    = "Enabled"
}

# Create the resource group for the event handler
# Azure > Turbot > Resource Group Handlers
resource "turbot_policy_setting" "resourceGroupStack" {
  resource = turbot_smart_folder.azure_folder.id
  type     = "tmod:@turbot/azure#/policy/types/resourceGroupStack"
  value    = "Enforce: Configured"
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
