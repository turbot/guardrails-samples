# Provider
provider "turbot" {
  profile = var.turbot_profile
}

# Smart Folder Definition
resource "turbot_smart_folder" "sf_aws_s3_calc_policy" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > S3 > Bucket > Public Access Block
resource "turbot_policy_setting" "aws_s3_bucket_public_access_block" {
  resource = turbot_smart_folder.sf_aws_s3_calc_policy.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlock"
  value    = local.public_access_block_settings_map[var.public_access_block_settings]
}

# AWS > S3 > Bucket > Public Access Block > Settings
resource "turbot_policy_setting" "aws_s3_bucket_public_access_block_settings" {
  resource       = turbot_smart_folder.sf_aws_s3_calc_policy.id
  type           = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlockSettings"
  template_input = <<EOT
{ 
  resource: bucket {
    publicAccessBlock: get(path:"PublicAccessBlock")
  }
}
  EOT
  template       = <<EOT
{%- set result = "" -%}
{%- set settings = ["${join("\", \"", var.public_access_block_settings_skip_list)}"] -%}
{%- set completedBlockPublicAcl = false -%}
{%- set completedBlockPublicBucketPolicies = false -%}
{%- set completedIgnorePublicACLs = false -%}
{%- set completedRestrictPublicBucketPolicies = false -%}

{%- for setting in settings -%}
    {%- if setting == "check_block_public_acls" -%}
        {%- set result = result + "- Block Public ACLs\n" -%}
        {%- set completedBlockPublicAcl = true -%}
    {%- elif setting == "uncheck_block_public_acls" -%}
        {%- set completedBlockPublicAcl = true -%}
    {%- endif -%}

    {%- if setting == "check_block_public_bucket_policies" -%}
        {%- set result = result + "- Block Public Bucket Policies\n" -%}
        {%- set completedBlockPublicBucketPolicies = true -%}
    {%- elif setting == "uncheck_block_public_bucket_policies" -%}
        {%- set completedBlockPublicBucketPolicies = true -%}
    {%- endif -%}

    {%- if setting == "check_ignore_public_acls" -%}
        {%- set result = result + "- Ignore Public ACLs\n" -%}
        {%- set completedIgnorePublicACLs = true -%}
    {%- elif setting == "uncheck_ignore_public_acls" -%}
        {%- set completedIgnorePublicACLs = true -%}
    {%- endif -%}

    {%- if setting == "check_restrict_public_bucket_policies" -%}
        {%- set result = result + "- Restrict Public Bucket Policies\n" -%}
        {%- set completedRestrictPublicBucketPolicies = true -%}
    {%- elif setting == "uncheck_restrict_public_bucket_policies" -%}
        {%- set completedRestrictPublicBucketPolicies = true -%}
    {%- endif -%}
{%- endfor -%}
{%- if completedBlockPublicAcl == false and $.resource.publicAccessBlock.BlockPublicAcls == true -%}
    {%- set result = result + "- Block Public ACLs\n" -%}
{%- endif -%}

{%- if completedBlockPublicBucketPolicies == false and $.resource.publicAccessBlock.BlockPublicPolicy == true -%}
    {%- set result = result + "- Block Public Bucket Policies\n" -%}
{%- endif -%}

{%- if completedIgnorePublicACLs == false and $.resource.publicAccessBlock.IgnorePublicAcls == true -%}
    {%- set result = result + "- Ignore Public ACLs\n" -%}
{%- endif -%}

{%- if completedRestrictPublicBucketPolicies == false and $.resource.publicAccessBlock.RestrictPublicBuckets == true -%}
    {%- set result = result + "- Restrict Public Bucket Policies\n" -%}
{%- endif -%}

{%- if result == "" -%}
[]
{%- else -%}
{{ result }}
{%- endif -%}
  EOT
}

# Attach Smart Folder
resource "turbot_smart_folder_attachment" "sf_attach_to_resource" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.sf_aws_s3_calc_policy.id
}

locals {
  public_access_block_settings_map = {
    skip : "Skip"
    check : "Check: Per `Public Access Block  > Settings`"
    enforce : "Enforce: Per `Public Access Block  > Settings`"
  }
}
