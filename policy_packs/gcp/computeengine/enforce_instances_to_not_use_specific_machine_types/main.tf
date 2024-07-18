resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP Compute Engine Instances to Not Use Specific Machine Types"
  description = "Enforce instances to not use specific machine types helps prevent the use of machine types that may be unsuitable for certain workloads, excessively costly, or lacking necessary security features, thereby optimizing resource utilization and maintaining a secure environment."
  akas        = ["gcp_computeengine_enforce_instances_to_not_use_specific_machine_types"]
}
