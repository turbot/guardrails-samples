# Create smart folder
resource "turbot_smart_folder" "s3_public_access" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to apply the s3 policy settings"
  parent        = "tmod:@turbot/turbot#/"
}

# Setting `AWS > S3 > Bucket > Public Access Block` to check a bucket for Public Access violations.
# AWS > S3 > Bucket > Public Access Block
resource "turbot_policy_setting" "s3_public_access_block" {
    resource = turbot_smart_folder.s3_public_access.id
    type = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlock"
    value = "Check: Per `Public Access Block  > Settings`"
}

# Values `AWS > S3 > Bucket > Public Access Block` policy points to
# AWS > S3 > Bucket > Public Access Block > Settings

resource "turbot_policy_setting" "s3_public_access_block_settings_acl" {
    resource = turbot_smart_folder.s3_public_access.id
    type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlockSettings"
    value = yamlencode(["Block Public ACLs","Block Public Bucket Policies","Restrict Public Bucket Policies"])
}

# Check S3 bucket policy for violations.
# AWS > S3 > Bucket > Policy Statements > Approved
resource "turbot_policy_setting" "s3_bucket_policy_statements_approved" {
    resource = turbot_smart_folder.s3_public_access.id
    type = "tmod:@turbot/aws-s3#/policy/types/bucketPolicyStatementsApproved"
    value = "Check: Approved"
}

# Check S3 bucket policy statement for Encryption at rest. If found, the bucket is approved
# AWS > S3 > Bucket > Policy Statements > Approved > Encryption at Rest
resource "turbot_policy_setting" "s3_bucket_policy_statements_encryption_at_rest" {
    resource = turbot_smart_folder.s3_public_access.id
    type = "tmod:@turbot/aws-s3#/policy/types/bucketPolicyStatementsApprovedEncryptionAtRest"
    value = "Enabled: Approve statements from `AWS > S3 > Bucket > Encryption at Rest`"
}

# S3 Public Access at the Account level. These settings can be configured in S3 at the account level to automatically
# apply to every existing and future bucket in said AWS account.
# AWS > S3 > Account > Public Access Block
resource "turbot_policy_setting" "s3_account_public_access_block"{
  resource = turbot_smart_folder.s3_public_access.id
  type = "tmod:@turbot/aws-s3#/policy/types/s3AccountPublicAccessBlock"
  value = "Check: Per `Public Access Block  > Settings`"
}

# AWS > S3 > Account > Public Access Block > Settings
resource "turbot_policy_setting" "s3_account_public_access_block_settings"{
  resource = turbot_smart_folder.s3_public_access.id
  type = "tmod:@turbot/aws-s3#/policy/types/s3AccountPublicAccessBlockSettings"
  value = "- Block Public ACLs\n- Block Public Bucket Policies\n- Ignore Public ACLs\n- Restrict Public Bucket Policies"
}