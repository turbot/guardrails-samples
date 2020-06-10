# Required - Tag key which should match between S3 Bucket and CMK
cross_resource_tag_key = "<tag key>"
# Examples for cross_resource_tag_key
# cross_resource_tag_key = "data_classification"

# Required - Target resource to attach to smart folder
target_resource = "<resource_id_or_aka>"
# Examples for target_resource
# target_resource = "tmod:@turbot/turbot#/"
# target_resource = "191926035367605"

# Optional - Default value: "AWS S3 - Encryption at Rest Customer Managed Key - Match tags on Bucket and CMK"
# smart_folder_title = "Custom Smart Folder Title"

# Optional - Default value: "RMatch tags on S3 Bucket and CMK"
# smart_folder_description = "Custom Description"

# Optional - Default value: tmod:@turbot/turbot#/
# smart_folder_parent_resource = "<resource_id_or_aka>"
