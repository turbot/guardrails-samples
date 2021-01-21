# Check for Public Access controls.

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}

## Create Smart Folder

resource "turbot_smart_folder" "azure_public_access" {
  parent = "tmod:@turbot/turbot#/"
  title  = "Azure Check Public Access Policies"
}