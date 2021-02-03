# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest
# Encryption in Transit Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-in-transit

# Encryption at Rest and In Transit.  Also in the Encryption Baseline

# AWS > S3 > Bucket > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/control/types/bucketEncryptionAtRest

resource "turbot_policy_setting" "s3_encryption_at_rest" {
    resource        = turbot_smart_folder.aws_encryption.id
    type            = "tmod:@turbot/aws-s3#/policy/types/bucketEncryptionAtRest"
    value           = "Check: AWS SSE or higher"
}

# AWS > S3 > Bucket > Encryption in Transit
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/control/types/encryptionInTransit
resource "turbot_policy_setting" "s3_encryption_in_transit" {
    resource        = turbot_smart_folder.aws_encryption.id
    type            = "tmod:@turbot/aws-s3#/policy/types/encryptionInTransit"
    value           = "Check: Enabled"
}
