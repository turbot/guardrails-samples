#### Configures the AWS provider to use a specific aws profile.
provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

# Creates AWS SNS Topic to which the Turbot notifications will be published.
resource "aws_sns_topic" "turbot_firehose_topic" {
  name = var.sns_topic_name
}

# Creates AWS IAM User for Turbot to authenticate to the AWS Account.
resource "aws_iam_user" "turbot_firehose_user" {
  name = var.aws_iam_username
}

# Creates AWS IAM User Access Keys for Turbot to authenticate to the AWS Account.
# WARNING: Note that the Secret Access Key will be written to the state file. If you use this, please protect your (backend) state file judiciously.
resource "aws_iam_access_key" "turbot_firehose_user_secretkeys" {
  user = aws_iam_user.turbot_firehose_user.name
}

# Creates AWS IAM User Policy with SNS:Publish action for Turbot to publish to SNS topic created above..
resource "aws_iam_user_policy" "turbot_firehose_user_policy" {
  name   = var.aws_iam_user_policy
  user   = aws_iam_user.turbot_firehose_user.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sns:Publish",
      "Resource": [
        "${aws_sns_topic.turbot_firehose_topic.arn}"
      ]
    }
  ]
}
EOF
}

# Turbot > Firehose > AWS SNS > Notification Access Key
resource "turbot_policy_setting" "firehose_aws_sns_notification_access_key" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/firehose-aws-sns#/policy/types/notificationAccessKey"
  value    = aws_iam_access_key.turbot_firehose_user_secretkeys.id
}

# Turbot > Firehose > AWS SNS > Notification Secret Key
# WARNING: Note that the Secret Access Key will be written to the state file. If you use this, please protect your (backend) state file judiciously.
resource "turbot_policy_setting" "firehose_aws_sns_notification_secret_key" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/firehose-aws-sns#/policy/types/notificationSecretKey"
  value    = aws_iam_access_key.turbot_firehose_user_secretkeys.secret
}

# Turbot > Firehose > AWS SNS > Notification Topic
resource "turbot_policy_setting" "firehose_aws_sns_notification_topic" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/firehose-aws-sns#/policy/types/notificationTopic"
  value    = aws_sns_topic.turbot_firehose_topic.arn
}

# Note: As of 14th September 2020, the turbot provider does not support create watch, using a null resource to excute the create watch using turbot cli.
# Tested on Turbot cli version 1.22.0
resource "null_resource" "turbot_mutation_example" {
  # Get notified on all the actions taken by Turbot for the resources at Turbot Root level and its descendant, which have turbot.tag as `Environment:Development`.
  provisioner "local-exec" {
    command = "turbot graphql --query mutation.graphql --variables variables.graphql"
  }
}
