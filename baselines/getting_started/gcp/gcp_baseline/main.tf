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

variable "service_status" {
  description = "Choose the subset of services that should be configured. Possible values for each service are: [\"Enabled\", \"Disabled\"]"
  type        = map
}

variable "policy_map" {
  description = "A map of all the services status policies currently available in Turbot"
  type        = map
}

variable "api_policy_map" {
  description = "Enter the list of API services that you would like to Enable"
  type        = map
}