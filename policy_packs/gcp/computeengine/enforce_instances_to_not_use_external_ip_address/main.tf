resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP Compute Engine Instances Do Not Use External IP Addresses"
  description = "Limiting instances to internal IP addresses only minimizes exposure to the internet, thereby protecting sensitive data and systems from unauthorized access and potential threats."
  akas        = ["gcp_computeengine_enforce_instances_to_not_use_external_ip_address"]
}
