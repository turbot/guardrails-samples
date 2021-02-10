resource "turbot_policy_setting" "firehose_aws_sns_notification_template_control_updated" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/firehose-aws-sns#/policy/types/notificationTemplateControlUpdated"
  value    = <<-EOT
    {% input %}
    query notificationGet($id: ID!) {
      notification(id: $id) {
        notificationType
        actor {
          identity {
            picture
            turbot {
              title
              id
            }
          }
        }
        turbot {
          type
          controlId
          controlOldVersionId
          controlNewVersionId
          createTimestamp
        }
        control {
          state
          reason
          details
          type {
            trunk {
              title
            }
          }
          turbot {
            id
          }
          resource {
            akas
            metadata
            title
            turbot {
              id
            }
          }
        }
        oldControl {
          state
          turbot {
            id
          }
        }
      }
    }
    {% endinput %}

    notification: {{ $.notification | dump | safe }}
    EOT
}

resource "turbot_policy_setting" "firehose_aws_sns_notification_access_key" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/firehose-aws-sns#/policy/types/notificationAccessKey"
  value    = local.access_key
}

resource "turbot_policy_setting" "firehose_aws_sns_notification_secret_key" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/firehose-aws-sns#/policy/types/notificationSecretKey"
  value    = local.secret_access_key
}

resource "turbot_policy_setting" "firehose_aws_sns_notification_topic" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/firehose-aws-sns#/policy/types/notificationTopic"
  value    = aws_sns_topic.turbot_firehose_user_sns_topic.arn
}

locals {
  access_key        = aws_iam_access_key.turbot_firehose_user_access_key.id
  secret_access_key = aws_iam_access_key.turbot_firehose_user_access_key.secret
}
