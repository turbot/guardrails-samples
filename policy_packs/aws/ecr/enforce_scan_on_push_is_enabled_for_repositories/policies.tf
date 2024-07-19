# AWS > ECR > Repository > Scan on Push
resource "turbot_policy_setting" "aws_ecr_repository_scan_on_push_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ecr#/policy/types/repositoryScanOnPush"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
