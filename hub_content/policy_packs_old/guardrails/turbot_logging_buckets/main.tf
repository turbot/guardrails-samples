# Create smart folder for policies
resource "turbot_smart_folder" "turbot_logging_buckets" {
    title       = var.smart_folder_title
    description = "Policies to check Turbot logging buckets for required metadata" 
    parent      = "tmod:@turbot/turbot#/"
}

# This stack configures an AWS S3 Bucket for use as a destination for logs from other AWS services.
# Set to check. Setting to Enabled: Configured will create logging buckets with specified requirements
# AWS > Turbot > Logging > Bucket
resource "turbot_policy_setting" "turbot_logging_bucket_check" {
    resource = turbot_smart_folder.turbot_logging_buckets.id
    type = "tmod:@turbot/aws#/policy/types/loggingBucket"
    value = "Check: Configured"
}

# Configure the Turbot Logging Bucket Encryption
# AWS > Turbot > Logging > Bucket > Default Encryption
resource "turbot_policy_setting" "turbot_logging_bucket_encryption" {
    resource = turbot_smart_folder.turbot_logging_buckets.id
    type = "tmod:@turbot/aws#/policy/types/loggingBucketDefaultEncryption"
    value = "AWS SSE"
}

# Configure the Turbot Logging Bucket Versioning
# Configure versioning on the AWS S3 Bucket.
# AWS > Turbot > Logging > Bucket > Versioning
resource "turbot_policy_setting" "turbot_logging_bucket_versioning" {
    resource = turbot_smart_folder.turbot_logging_buckets.id
    type = "tmod:@turbot/aws#/policy/types/loggingBucketVersioning"
    value = "Enabled"
}

# Configure the Turbot Logging Bucket Regions
# A list of regions in which to create Turbot logging buckets. This stack configures an AWS S3 Bucket for use as a destination for logs from other AWS services.
# AWS > Turbot > Logging > Bucket > Regions
resource "turbot_policy_setting" "turbot_logging_bucket_regions" {
    resource = turbot_smart_folder.turbot_logging_buckets.id
    type = "tmod:@turbot/aws#/policy/types/loggingBucketRegions"
    value = yamlencode([{approvedRegionsPolicy: policy(uri: "#/policy/types/approvedRegionsDefault", resourceId: "{{ $.account.turbot.id }}")}])
}