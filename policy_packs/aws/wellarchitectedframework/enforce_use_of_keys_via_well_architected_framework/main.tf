resource "turbot_policy_pack" "main" {
  title       = "Enforce Use of Keys Via AWS Well-Architected Tool Well-Architected Framework Security"
  description = "Ensure data integrity and confidentiality."
  akas        = ["aws_well_architected_tool_enforce_use_of_keys_via_well_architected_framework"]
}