# Required

# None

# Optional

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
  default     = "default"
}

resource "turbot_smart_folder" "gcp_baseline" {
  parent = "tmod:@turbot/turbot#/"
  title  = "GCP Check Baseline Policies"
}

variable "service_status" {
  description = "Choose the subset of services that should be configured. Possible values for each service are: [\"Enabled\", \"Disabled\"]"
  type        = map(any)
}

variable "policy_map" {
  description = "A map of all the services status policies currently available in Turbot"
  type        = map(any)
}
