resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS IAM Access Keys Are Not Older Than 90 Days"
  description = "Reduce the risk of compromised credentials by ensuring keys are regularly rotated."
  akas        = ["aws_iam_enforce_access_keys_are_not_older_than_90_days"]
}
