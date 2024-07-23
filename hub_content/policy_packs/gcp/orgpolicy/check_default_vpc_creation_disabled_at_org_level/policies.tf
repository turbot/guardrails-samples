# GCP > Project > Organization Policy > Skip default network creation
resource "turbot_policy_setting" "gcp_org_policy_compute_skip_default_network_creation" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-orgpolicy#/policy/types/computeSkipDefaultNetworkCreation"
  value    = "Check: On, effective value"
  # value    = "Check: On, set on project"
  # value    = "Check: On, inherited"
}
