## SMART FOLDER Control Objectives
## Description: AWS Baseline policies:
# Sevice Enablement
# Event Handlers
# Regions for Event Handlers
# Misc common controls e.g. Default VPCs

variable "turbot_profile" {
  description = "Enter profile matching your Turbot CLI credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}

## Create Smart Folder

resource "turbot_smart_folder" "aws_baseline" {
  parent = "tmod:@turbot/turbot#/"
  title  = "AWS Baseline Policies"
}
