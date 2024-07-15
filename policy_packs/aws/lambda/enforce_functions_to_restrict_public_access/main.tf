resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS Lambda Functions to Restrict Public Access"
  description = "Prevent unauthorized users from invoking functions, which can lead to security vulnerabilities and potential data breaches."
  akas        = ["aws_lambda_enforce_functions_to_restrict_public_access"]
}
