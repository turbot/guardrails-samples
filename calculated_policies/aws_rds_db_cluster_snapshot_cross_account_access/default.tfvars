# Required - Target the accounts numbers that are approved to use cross-account snapshots
approved_accounts = []
# Examples for approved_accounts
# ["012345678901", "109876543210"]

# Required - Target resource to attach to smart folder
target_resource = "<resource_id or aka>"
# Examples for target_resource
# target_resource = "tmod:@turbot/turbot#/"
# target_resource = "191238958290468"

# Optional - Default value: "RDS Snapshot Cross Account Access"
# smart_folder_title = "Custom Smart Folder Title"

# Optional - Default value: "Restrict cross-account access to RDS snapshots"
# smart_folder_description = "Custom Description"

# Optional - Default value: tmod:@turbot/turbot#/
# smart_folder_parent_resource = "<resource_id_or_aka>"
