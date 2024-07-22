resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP Compute Engine Disks To Be Attached To An Instance"
  description = "This practice helps avoid unnecessary costs associated with unattached disks, reduces the risk of data exposure, and ensures that all storage resources are actively managed and utilized."
  akas        = ["gcp_compute_engine_enforce_disks_to_be_attached_to_an_instance"]
}
