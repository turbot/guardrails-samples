# Required - List of approved AWS account to own trusted AMIs
approved_account_ami_list = []
# Examples for approved_account_ami_list
# ["235268162285", "235268162286"]

# Required - Target resource to attach to smart folder
target_resource = "<resource_id or aka>"
# Examples for target_resource
# target_resource = "tmod:@turbot/turbot#/"
# target_resource = "191926035367605"

# Optional - Default value: "AWS EC2 Instance Approved Account AMIs"
# smart_folder_title = "Custom Smart Folder Title"

# Optional - Default value: "Restrict AWS EC2 Instance image to approved account AMIs"
# smart_folder_description = "Custom Description"

# Optional - Default value: tmod:@turbot/turbot#/
# smart_folder_parent_resource = "<resource_id_or_aka>"
