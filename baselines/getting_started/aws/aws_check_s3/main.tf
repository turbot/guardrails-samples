# AWS Check S3 Policies focuses on an example of a deeper baseline for a specific service
# Some of these policies overlap with other baselines.  
# With the setup of each baseline in each Smart Folder, there is no conflict on the policy settings

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}

## Create Smart Folder

resource "turbot_smart_folder" "aws_all_s3" {
  parent = "tmod:@turbot/turbot#/"
  title  = "AWS Check S3 Policies"
}


## Vars

variable "trusted_accounts" {
  type = list(string)
}
