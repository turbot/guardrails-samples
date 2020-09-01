# Required - Target the accounts that are approved to use AWS S3 Bucket ACL cross-account access
# This variable expects a list of Canonical IDs
# Read more about Canonical user IDs: https://docs.aws.amazon.com/general/latest/gr/acct-identifiers.html
approved_accounts = []
# Examples for approved_accounts
# approved_accounts = ["14dc98d5f2185f3d62afcc95361dd156098a788f09fdd581d68710b503cfad09"]

# Required - Target resource to attach to smart folder
target_resource = "<resource_id or aka>"
# Examples for target_resource
# target_resource = "tmod:@turbot/turbot#/"
# target_resource = "191926035367605"

# Optional - Default value: "S3 Bucket ACL Cross-Account Access"
# smart_folder_title = "Custom Smart Folder Title"

# Optional - Default value: "Restrict AWS S3 Bucket ACL cross-account access to approved accounts"
# smart_folder_description = "Custom Description"

# Optional - Default value: tmod:@turbot/turbot#/
# smart_folder_parent_resource = "<resource_id_or_aka>"
