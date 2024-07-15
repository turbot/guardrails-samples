resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP IAM User-Managed Service Account Keys Are Rotated Every 90 Days"
  description = "Regular key rotation ensures that any potentially exposed or compromised keys are rendered obsolete."
  akas        = ["gcp_computeengine_enforce_instances_to_not_use_external_ip_address"]
}
