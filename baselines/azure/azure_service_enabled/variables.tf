variable "enabled_policy_map" {
  description = "Enter the list of services that you would like to Enable"
  type        = map(string)
}

variable "provider_status" {
  description = <<-EOF
    Choose the subset of providers that should be configured.
    Possible values for each service are: 
      - "Skip"
      - "Check: Not Registered"
      - "Check: Registered"
      - "Enforce: Not Registered"
      - "Enforce: Registered"
    EOF
  type        = map(string)
}

variable "provider_registration_map" {
  description = "A map of all the registered policies currently exposed by Turbot"
  type        = map(string)
}
