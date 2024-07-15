resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP Compute Engine Instances to Not Use External IP Addresses"
  description = "Limiting instances to internal IP addresses only minimizes exposure to the internet, thereby protecting sensitive data and systems from unauthorized access and potential threats."
}
