resource "turbot_policy_pack" "main" {
  title       = "Enforce Data Residency for Anthropic Workspaces"
  description = "Keep Anthropic workspace inference within approved geographies by requiring data residency to be configured with an allowed set of inference geos and a default geo."
  akas        = ["anthropic_enforce_data_residency_for_workspaces"]
}
