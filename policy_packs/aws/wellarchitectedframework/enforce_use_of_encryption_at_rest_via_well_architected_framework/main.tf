resource "turbot_policy_pack" "main" {
  title       = "Enforce Use of Encryption at Rest Via AWS Well-Architected Tool Well-Architected Framework Security"
  description = "Ensure that data is protected from unauthorized access and potential breaches."
  akas        = ["aws_well_architected_tool_enforce_use_of_encryption_at_rest_via_well_architected_framework"]
}