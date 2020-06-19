resource "turbot_smart_folder" "azure_folder" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# Create Event through Event Poller
# Azure > Turbot > Event Poller
resource "turbot_policy_setting" "eventPoller" {
  resource = turbot_smart_folder.azure_folder.id
  type     = "tmod:@turbot/azure#/policy/types/eventPoller"
  value    = var.enable_poller ? "Enabled" : "Disabled"
}

# Create the resource group for the event handler
# Azure > Turbot > Resource Group Handlers
resource "turbot_policy_setting" "resourceGroupStack" {
  resource = turbot_smart_folder.azure_folder.id
  type     = "tmod:@turbot/azure#/policy/types/resourceGroupStack"
  value    = var.enable_poller ? "Skip" : "Enforce: Configured"
}

# Create Event through Event Handler
# Azure > Turbot > Event Handlers
resource "turbot_policy_setting" "eventHandlers" {
  resource = turbot_smart_folder.azure_folder.id
  type     = "tmod:@turbot/azure#/policy/types/eventHandlers"
  value    = var.enable_poller ? "Skip" : "Enforce: Configured"
}

# Create the Resource Group and set the policy
# Azure > Turbot > Resource Group
resource "turbot_policy_setting" "turbotResourceGroup" {
  resource = turbot_smart_folder.azure_folder.id
  type     = "tmod:@turbot/azure#/policy/types/turbotResourceGroup"
  value    = var.enable_poller ? "Skip" : "Enforce: Configured"
}

resource "turbot_smart_folder_attachment" "azure_folder" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.azure_folder.id
}
