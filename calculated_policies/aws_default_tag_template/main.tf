## SMART FOLDER TEMPLATE: aws_tagging_v001
## Description: Sets default tag template to validate 3 Tags:
##     owner:       Must exist and be a valid email address
##     costcenter:  Must exist
##     environment: Must exist and be one of ['dev', 'test', 'prod']
##
## If the tags do not exist, we will create them with a default
## value pulled from the enclosing turbot folder.
##
## If the enclosing folder has no default value then the resource 
## will be tagged with "__Missing Tag__"

provider "turbot" {
}

## Create Smart Folder at the Turbot level

resource "turbot_smart_folder" "aws_tagging" {
  parent       = "tmod:@turbot/turbot#/"
  title        = "AWS Default Tagging Template Policies"
}

## Smart Folder Attachments 
## Add your smart folder attachments here or attach manually

# resource "turbot_smart_folder_attachment" "auto_attach" {
#   resource     = "123456789012345"  ##  Enter Folder ID here
#   smart_folder = turbot_smart_folder.aws_tagging.id
# }

