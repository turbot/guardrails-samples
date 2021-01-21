## GCP Baseline policies:
   # Sevice Enablement
   # Service API Enablement
   # Event Polling
   # Enable CIS

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile     = var.turbot_profile
}

## Create Smart Folder

resource "turbot_smart_folder" "gcp_baseline" {
  parent       = "tmod:@turbot/turbot#/"
  title        = "GCP Check Baseline Policies"
}