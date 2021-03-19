## Create Smart Folder at the Turbot level

resource "turbot_smart_folder" "aws_tagging" {
  parent       = var.smart_folder_parent_resource
  title        = var.smart_folder_title
  description  = var.smart_folder_description
}

## Smart Folder Attachments 
## Add your smart folder attachments here or attach manually

# resource "turbot_smart_folder_attachment" "auto_attach" {
#   resource     = "123456789012345"  ##  Enter Folder ID here
#   smart_folder = turbot_smart_folder.aws_tagging.id
# }