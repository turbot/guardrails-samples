# Required - Target the accounts that are approved to use cross-account replication
approved_accounts = []
# Examples for approved_accounts
# ["235268162285", "109876543210"]

# Required - Target resource to attach to smart folder
target_resource = "<resource_id or aka>"
# Examples for target_resource
# target_resource = "tmod:@turbot/turbot#/"
# target_resource = "191926035367605"

# Optional - Default value: "S3 Bucket Cross Account Replication"
# smart_folder_title = "Custom Smart Folder Title"

# Optional - Default value: "Restrict AWS S3 Bucket cross-account replication to approved accounts"
# smart_folder_description = "Custom Description"

# Optional - Default value: tmod:@turbot/turbot#/
# smart_folder_parent_resource = "<resource_id_or_aka>"
