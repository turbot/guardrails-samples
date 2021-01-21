# GCP IAM governance controls

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}

## Create Smart Folder

resource "turbot_smart_folder" "gcp_iam" {
  parent = "tmod:@turbot/turbot#/"
  title  = "GCP Check IAM Policies"
}
