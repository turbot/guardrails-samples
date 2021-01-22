# Trusted Account Template - sets the global template for S3 Buckets specifically, pulls from tfvars file
# This is a specific service example, the global template from the Public Access baseline can be used as well
# More Info: https://turbot.com/v5/docs/concepts/guardrails/trusted-access


resource "turbot_policy_setting" "aws_s3_trusted_accounts_template" {
    resource        = turbot_smart_folder.aws_all_s3.id
    type            = "tmod:@turbot/aws-s3#/policy/types/bucketPolicyTrustedAccounts"
    template_input    = <<-QUERY
    {
    account{
     Id
      }
    }
    QUERY

  # set trustedAccounts from terraform.tfvars
    template          = <<-TEMPLATE
    ${yamlencode([for account in var.trusted_accounts : account])}
    TEMPLATE
}