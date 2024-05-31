# Trusted Access Guardrails
#   https://turbot.com/v5/docs/concepts/guardrails/trusted-access

# Trusted Accounts Access controls
# Will inherit the trusted accounts from Public Access baseline or from what is set in this baseline

# AWS > S3 > Bucket > Policy > Trusted Access
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketPolicyTrustedAccess
resource "turbot_policy_setting" "aws_s3_bucket_policy_trusted_access" {
  count    = var.enable_s3_trusted_access_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketPolicyTrustedAccess"
  value    = "Check: Trusted Access"
}

# Trusted account calculated policy sets the global template for S3 Buckets specifically. 
# It will add trusted accounts which are provided externally by the user of the Terraform script. 
# The global template from the Public Access baseline can be used as well.

# AWS > S3 > Bucket > Policy > Trusted Access > Accounts
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/bucketPolicyTrustedAccounts
resource "turbot_policy_setting" "aws_s3_trusted_accounts_template" {
  count          = var.enable_s3_trusted_access_policies ? 1 : 0
  resource       = turbot_smart_folder.aws_all_s3.id
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketPolicyTrustedAccounts"
  template_input = <<-QUERY
    {
      account {
        Id
      }
    }
  QUERY

  # set trustedAccounts from terraform.tfvars
  template = <<-TEMPLATE
    ${yamlencode([for account in var.trusted_accounts : account])}
  TEMPLATE
}
