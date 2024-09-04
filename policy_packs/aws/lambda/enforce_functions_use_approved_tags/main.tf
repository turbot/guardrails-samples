resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS Lambda Functions Use Approved Tags"
  description = "Ensure proper resource management, cost tracking, and compliance with organizational policies by enabling the identification and classification of Lambda functions based on their purpose, environment, and other relevant criteria."
  akas        = ["aws_lambda_enforce_functions_use_approved_tags"]
}
