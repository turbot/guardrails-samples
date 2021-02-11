# Policies delete unapproved Streams that are unencrypted
# Commented out since these services are not associated to the initial mod install list


# resource "turbot_policy_setting" "aws_kinesis_stream_approved" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-kinesis#/policy/types/streamApproved"
#   value    = "Check: Approved"
# }


# resource "turbot_policy_setting" "aws_kinesis_approved_usage" {
#   resource       = turbot_smart_folder.aws_encryption.id
#   type           = "tmod:@turbot/aws-kinesis#/policy/types/streamApprovedUsage"
#   template_input = <<-QUERY
#         {
#         stream {
#             EncryptionType
#             KeyId
#             }
#         }
#         QUERY

#   # Nunjucks template evaluate metadata.
#   template = <<-TEMPLATE
#         {%- if $.stream.EncryptionType == "KMS" -%}
#         "Approved"
#         {%- else -%}
#         "Not approved"
#         {%- endif -%}
#         TEMPLATE
# }
