# Ensure encryption in transit and at rest on S3 Buckets
# Note: these are also part of the S3 Baseline as well


resource "turbot_policy_setting" "s3_encryption_at_rest" {
    resource        = turbot_smart_folder.aws_encryption.id
    type            = "tmod:@turbot/aws-s3#/policy/types/bucketEncryptionAtRest"
    value           = "Check: AWS SSE or higher"
}

resource "turbot_policy_setting" "s3_encryption_in_transit" {
    resource        = turbot_smart_folder.aws_encryption.id
    type            = "tmod:@turbot/aws-s3#/policy/types/encryptionInTransit"
    value           = "Check: Enabled"
}
