# AWS > IAM > Stack
resource "turbot_policy_setting" "aws_iam_stack" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStack"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > IAM > Stack > Source
resource "turbot_policy_setting" "aws_iam_stack_source" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/aws-iam#/policy/types/iamStackSource"
  template_input = <<-EOT
    {
      account  {
        Id
        metadata
      }
    }
    EOT
  template       = <<-EOT
    |
    resource "aws_iam_policy" "deny_aws_config_changes" {
      name        = "deny_aws_config_changes"
      description = "Disallow configuration changes to AWS config"
      policy      = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "GRCONFIGENABLED",
                "Effect": "Deny",
                "Action": [
                    "config:DeleteConfigurationRecorder",
                    "config:DeleteDeliveryChannel",
                    "config:DeleteRetentionConfiguration",
                    "config:PutConfigurationRecorder",
                    "config:PutDeliveryChannel",
                    "config:PutRetentionConfiguration",
                    "config:StopConfigurationRecorder"
                ],
                "Resource": ["*"],
                "Condition": {
                    "ArnNotLike": {
                        "aws:PrincipalARN":"arn:{{ $.account.metadata.aws.partition }}:iam::{{ $.account.Id }}:role/AWSControlTowerExecution"
                    }
                }
            }
        ]
    }
    EOF
    }
    EOT
}

# AWS > IAM > Stack > Terraform Version
resource "turbot_policy_setting" "aws_iam_iam_stack_terraform_version" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStackTerraformVersion"
  value    = "0.15.*"
}