# GCP Encryption Policies for common encryption in transit and at rest controls
# More Info at Rest: https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest
# More Info in Transit: https://turbot.com/v5/docs/concepts/guardrails/encryption-in-transit

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}

## Create Smart Folder

resource "turbot_smart_folder" "gcp_encryption" {
  parent = "tmod:@turbot/turbot#/"
  title  = "GCP Check Encryption Policies"
}
