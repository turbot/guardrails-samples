resource "turbot_policy_pack" "main" {
  title       = "Deploy AWS IAM Stack"
  description = "Deploy and manage AWS IAM resources using OpenTofu with AWS > IAM > Stack [Native] control."
  akas        = ["aws_iam_deploy_aws_iam_stack"]
}