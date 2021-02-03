#Azure Baseline policies:
   # Sevice Enablement
   # Provider Enablement
   # Event Polling
   # Enable CIS

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile     = var.turbot_profile
}
## Create Smart Folder

resource "turbot_smart_folder" "azure_baseline" {
  parent       = "tmod:@turbot/turbot#/"
  title        = "Azure Baseline Policies"
}

variable "provider_status" {
  description = "Choose the subset of providers that should be configured. Possible values for each service are: [\"Skip\", \"Check: Not Registered\", \"Check: Registered\", \"Enforce: Not Registered\", \"Enforce: Registered\"]"
  type        = map
}

variable "provider_registration_map" {
  description = "A map of all the registered policies currently exposed by Turbot"
  type        = map
}

variable "enabled_policy_map" {
  description = "Enter the list of services that you would like to Enable"
  type        = map
}