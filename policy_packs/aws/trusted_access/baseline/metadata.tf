resource "turbot_file" "trusted_access_exceptions" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "AWS Trusted Access Exceptions"
  description = "Configuration for AWS trusted access exceptions"
  akas        = ["aws_trusted_access_exceptions_config"]
  content = jsonencode(local.trusted_access_exceptions_json_with_accounts)
}