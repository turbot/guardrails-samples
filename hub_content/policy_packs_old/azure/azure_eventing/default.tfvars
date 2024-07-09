# Required - Target resource to attach to smart folder
target_resource = "<resource_id_or_aka>"
# Examples for target_resource
# target_resource = "tmod:@turbot/turbot#/"
# target_resource = "191238958290468"

# Required - Target resource to attach to smart folder
#  Setting to `true` will configure that the Event Poller to handle event routing.
#  Setting to `false` will configure that the Event Handler to handle event routing.
enable_poller = true

# Optional - Default value: "Azure - Event Router"
# smart_folder_title = "Custom Smart Folder Title"

# Optional - Default value: "Contains the policy settings to configure the Azure Event Router"
# smart_folder_description = "Custom Description"

# Optional - Default value: tmod:@turbot/turbot#/
# smart_folder_parent_resource = "<resource_id_or_aka>"
