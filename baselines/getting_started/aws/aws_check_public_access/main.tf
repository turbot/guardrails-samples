# Check for Public & Trusted Account controls.
# List of Trusted Accounts are set in the variables file
# Current list are just Turbot accounts as examples

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}

## Create Smart Folder

resource "turbot_smart_folder" "aws_public_access" {
  parent = "tmod:@turbot/turbot#/"
  title  = "AWS Check Public Access Policies"
}


## Vars

variable "trusted_accounts" {
  type = list(string)
}
