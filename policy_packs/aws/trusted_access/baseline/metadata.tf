resource "turbot_file" "trusted_access_exceptions" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "AWS Trusted Access Exceptions"
  description = "Configuration for AWS trusted access exceptions"
  akas        = ["aws_trusted_access_exceptions_config"]

  # Content contains:
  # - "baseline": List of account IDs trusted by default
  # - Account-specific configurations with each AWS account ID as the key
  #   and a list of trusted account IDs as the value
  content = jsonencode(local.trusted_access_exceptions_json_with_accounts)
}