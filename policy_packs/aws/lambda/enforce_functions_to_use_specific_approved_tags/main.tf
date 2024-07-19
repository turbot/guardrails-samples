resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS Lambda Functions To Use Specific Approved Tags"
  description = "Ensure that only authorized functions are executed, preventing potential vulnerabilities and misuse while optimizing resource allocation and controlling expenses."
  akas        = ["aws_lambda_enforce_functions_to_use_specific_approved_tags"]
}
