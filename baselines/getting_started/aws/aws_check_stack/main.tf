# AWS Account Stack with an IAM Role Example
# Also a good example of how to include a TF file in a Turbot TF
# More Info: https://turbot.com/v5/docs/concepts/guardrails/configured

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}


## Create Smart Folder at the Turbot level

resource "turbot_smart_folder" "aws_stack" {
  parent = "tmod:@turbot/turbot#/"
  title  = "AWS Stack Example Policies"
}
