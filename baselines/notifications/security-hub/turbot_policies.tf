# Turbot > Firehose > AWS SNS > Notification Template > Control Updated
# https://turbot.com/v5/mods/turbot/firehose-aws-sns/inspect#/policy/types/notificationTemplateControlUpdated
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

# Turbot > Firehose > AWS SNS > Notification Access Key
# https://turbot.com/v5/mods/turbot/firehose-aws-sns/inspect#/policy/types/notificationAccessKey
resource "turbot_policy_setting" "firehose_aws_sns_notification_access_key" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/firehose-aws-sns#/policy/types/notificationAccessKey"
  value    = local.access_key
}

# Turbot > Firehose > AWS SNS > Notification Secret Key
# https://turbot.com/v5/mods/turbot/firehose-aws-sns/inspect#/policy/types/notificationSecretKey
resource "turbot_policy_setting" "firehose_aws_sns_notification_secret_key" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/firehose-aws-sns#/policy/types/notificationSecretKey"
  value    = local.secret_access_key
}

# Turbot > Firehose > AWS SNS > Notification Topic
# https://turbot.com/v5/mods/turbot/firehose-aws-sns/inspect#/policy/types/notificationTopic
resource "turbot_policy_setting" "firehose_aws_sns_notification_topic" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/firehose-aws-sns#/policy/types/notificationTopic"
  value    = aws_sns_topic.turbot_firehose_user_sns_topic.arn
}
