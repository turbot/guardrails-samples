# AWS Elasticsearch Encryption controls
# Commented out since these services are not associated to the initial mod install list

# resource "turbot_policy_setting" "aws_elasticsearch_approved" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-elasticsearch#/policy/types/domainApproved"
#   value    = "Check: Approved"
# }

# resource "turbot_policy_setting" "aws_elasticsearch_encryption_at_rest" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-elasticsearch#/policy/types/domainEncryptionAtRest"
#   value    = "AWS managed key or higher"
# }
