# AWS IAM over permissive and trusted access controls

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}

## Create Smart Folder

resource "turbot_smart_folder" "aws_iam" {
  parent = "tmod:@turbot/turbot#/"
  title  = "AWS Check IAM Policies"
}
