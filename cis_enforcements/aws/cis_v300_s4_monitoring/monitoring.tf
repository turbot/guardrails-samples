# AWS > Region > Stack
# The below settings assumes a CloudTrail Trail and an associated CloudWatch Log Group is available from CIS section 3.01 and 3.04 samples

resource "turbot_policy_setting" "aws_region_stack" {
  resource = turbot_smart_folder.aws_cis_v300_s4_monitoring.id
  type     = "tmod:@turbot/aws#/policy/types/regionStack"
  note     = "AWS CIS v3.0.0 - Controls:  4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9, 4.10, 4.11, 4.12, 4.13, 4.14, 4.15, 4.16"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"

}

# AWS > Region > Stack > Source
resource "turbot_policy_setting" "aws_region_stack_source" {
  resource       = turbot_smart_folder.aws_cis_v300_s4_monitoring.id
  type           = "tmod:@turbot/aws#/policy/types/regionStackSource"
  note           = "AWS CIS v3.0.0 - Controls:  4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9, 4.10, 4.11, 4.12, 4.13, 4.14, 4.15, 4.16"
  template_input = <<-EOT
    {
      region  {
        metadata
      }
    }
    EOT
  template       = <<-EOT
    |
    resource "aws_sns_topic" "metric_alarm_topic" {
      name = var.sns_topic
    }

    resource "aws_sns_topic_subscription" "metric_alarm_subscription" {
      topic_arn = aws_sns_topic.metric_alarm_topic.arn
      protocol  = "<protocol_for_sns>"              # Replace with your protocol (e.g., email, sms, etc.)
      endpoint  = "<sns_subscription_endpoints>"    # Replace with your endpoint
    }

    resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_4_1" {
      name           = var.log_metric_filter_name_4_1
      # Log Group from section 3.04
      log_group_name = aws_cloudwatch_log_group.log_group.name
      pattern        = "{ ($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\") }"

      metric_transformation {
        name      = var.log_metric_filter_name_4_1
        namespace = "CISBenchmark"
        value     = "1"
      }
    }

    resource "aws_cloudwatch_metric_alarm" "log_metric_alarm_4_1" {
      alarm_name          = var.log_metric_alarm_name_4_1
      metric_name         = aws_cloudwatch_log_metric_filter.log_metric_filter_4_1.name
      namespace           = "CISBenchmark"
      statistic           = "Sum"
      period              = 300
      evaluation_periods  = 1
      threshold           = 1
      comparison_operator = "GreaterThanOrEqualToThreshold"
      alarm_actions       = [aws_sns_topic.metric_alarm_topic.arn] 
    }

    resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_4_2" {
      name           = var.log_metric_filter_name_4_2
      # Log Group from section 3.04
      log_group_name = aws_cloudwatch_log_group.log_group.name
      pattern        = "{ ($.eventName = \"ConsoleLogin\") && ($.additionalEventData.MFAUsed != \"Yes\") }"

      metric_transformation {
        name      = var.log_metric_filter_name_4_2
        namespace = "CISBenchmark"
        value     = "1"
      }
    }

    resource "aws_cloudwatch_metric_alarm" "log_metric_alarm_4_2" {
      alarm_name          = var.log_metric_alarm_name_4_2
      metric_name         = aws_cloudwatch_log_metric_filter.log_metric_filter_4_2.name
      namespace           = "CISBenchmark"
      statistic           = "Sum"
      period              = 300
      evaluation_periods  = 1
      threshold           = 1
      comparison_operator = "GreaterThanOrEqualToThreshold"
      alarm_actions       = [aws_sns_topic.metric_alarm_topic.arn] 
    }

    resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_4_3" {
      name           = var.log_metric_filter_name_4_3
      # Log Group from section 3.04
      log_group_name = aws_cloudwatch_log_group.log_group.name
      pattern        = "{ $.userIdentity.type = \"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType != \"AwsServiceEvent\" }"

      metric_transformation {
        name      = var.log_metric_filter_name_4_3
        namespace = "CISBenchmark"
        value     = "1"
      }
    }

    resource "aws_cloudwatch_metric_alarm" "log_metric_alarm_4_3" {
      alarm_name          = var.log_metric_alarm_name_4_3
      metric_name         = aws_cloudwatch_log_metric_filter.log_metric_filter_4_3.name
      namespace           = "CISBenchmark"
      statistic           = "Sum"
      period              = 300
      evaluation_periods  = 1
      threshold           = 1
      comparison_operator = "GreaterThanOrEqualToThreshold"
      alarm_actions       = [aws_sns_topic.metric_alarm_topic.arn] 
    }

    resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_4_4" {
      name           = var.log_metric_filter_name_4_4
      # Log Group from section 3.04
      log_group_name = aws_cloudwatch_log_group.log_group.name
      pattern        = "{ ($.eventName= \"DeleteGroupPolicy\") || ($.eventName= \"DeleteRolePolicy\") || ($.eventName= \"DeleteUserPolicy\") || ($.eventName= \"PutGroupPolicy\") || ($.eventName= \"PutRolePolicy\") || ($.eventName= \"PutUserPolicy\") || ($.eventName= \"CreatePolicy\") || ($.eventName= \"DeletePolicy\") || ($.eventName= \"CreatePolicyVersion\") || ($.eventName= \"DeletePolicyVersion\") || ($.eventName= \"AttachRolePolicy\") || ($.eventName= \"DetachRolePolicy\") || ($.eventName= \"AttachUserPolicy\") || ($.eventName= \"DetachUserPolicy\") || ($.eventName= \"AttachGroupPolicy\") || ($.eventName= \"DetachGroupPolicy\") }"

      metric_transformation {
        name      = var.log_metric_filter_name_4_4
        namespace = "CISBenchmark"
        value     = "1"
      }
    }

    resource "aws_cloudwatch_metric_alarm" "log_metric_alarm_4_4" {
      alarm_name          = var.log_metric_alarm_name_4_4
      metric_name         = aws_cloudwatch_log_metric_filter.log_metric_filter_4_4.name
      namespace           = "CISBenchmark"
      statistic           = "Sum"
      period              = 300
      evaluation_periods  = 1
      threshold           = 1
      comparison_operator = "GreaterThanOrEqualToThreshold"
      alarm_actions       = [aws_sns_topic.metric_alarm_topic.arn] 
    }

    resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_4_5" {
      name           = var.log_metric_filter_name_4_5
      # Log Group from section 3.04
      log_group_name = aws_cloudwatch_log_group.log_group.name
      pattern        = "{ ($.eventName = \"CreateTrail\") || ($.eventName = \"UpdateTrail\") || ($.eventName = \"DeleteTrail\") || ($.eventName = \"StartLogging\") || ($.eventName = \"StopLogging\") }"

      metric_transformation {
        name      = var.log_metric_filter_name_4_5
        namespace = "CISBenchmark"
        value     = "1"
      }
    }

    resource "aws_cloudwatch_metric_alarm" "log_metric_alarm_4_5" {
      alarm_name          = var.log_metric_alarm_name_4_5
      metric_name         = aws_cloudwatch_log_metric_filter.log_metric_filter_4_5.name
      namespace           = "CISBenchmark"
      statistic           = "Sum"
      period              = 300
      evaluation_periods  = 1
      threshold           = 1
      comparison_operator = "GreaterThanOrEqualToThreshold"
      alarm_actions       = [aws_sns_topic.metric_alarm_topic.arn] 
    }

    resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_4_6" {
      name           = var.log_metric_filter_name_4_6
      # Log Group from section 3.04
      log_group_name = aws_cloudwatch_log_group.log_group.name
      pattern        = "{ ($.eventName = \"ConsoleLogin\") && ($.errorMessage = \"Failed authentication\") }"

      metric_transformation {
        name      = var.log_metric_filter_name_4_6
        namespace = "CISBenchmark"
        value     = "1"
      }
    }

    resource "aws_cloudwatch_metric_alarm" "log_metric_alarm_4_6" {
      alarm_name          = var.log_metric_alarm_name_4_6
      metric_name         = aws_cloudwatch_log_metric_filter.log_metric_filter_4_6.name
      namespace           = "CISBenchmark"
      statistic           = "Sum"
      period              = 300
      evaluation_periods  = 1
      threshold           = 1
      comparison_operator = "GreaterThanOrEqualToThreshold"
      alarm_actions       = [aws_sns_topic.metric_alarm_topic.arn] 
    }

    resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_4_7" {
      name           = var.log_metric_filter_name_4_7
      # Log Group from section 3.04
      log_group_name = aws_cloudwatch_log_group.log_group.name
      pattern        = "{ ($.eventSource = \"kms.amazonaws.com\") && (($.eventName= \"DisableKey\") || ($.eventName= \"ScheduleKeyDeletion\")) }"

      metric_transformation {
        name      = var.log_metric_filter_name_4_7
        namespace = "CISBenchmark"
        value     = "1"
      }
    }

    resource "aws_cloudwatch_metric_alarm" "log_metric_alarm_4_7" {
      alarm_name          = var.log_metric_alarm_name_4_7
      metric_name         = aws_cloudwatch_log_metric_filter.log_metric_filter_4_7.name
      namespace           = "CISBenchmark"
      statistic           = "Sum"
      period              = 300
      evaluation_periods  = 1
      threshold           = 1
      comparison_operator = "GreaterThanOrEqualToThreshold"
      alarm_actions       = [aws_sns_topic.metric_alarm_topic.arn] 
    }

    resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_4_8" {
      name           = var.log_metric_filter_name_4_8
      # Log Group from section 3.04
      log_group_name = aws_cloudwatch_log_group.log_group.name
      pattern        = "{ ($.eventSource = \"s3.amazonaws.com\") && (($.eventName = \"PutBucketAcl\") || ($.eventName = \"PutBucketPolicy\") || ($.eventName = \"PutBucketCors\") || ($.eventName = \"PutBucketLifecycle\") || ($.eventName = \"PutBucketReplication\") || ($.eventName = \"DeleteBucketPolicy\") || ($.eventName = \"DeleteBucketCors\") || ($.eventName = \"DeleteBucketLifecycle\") || ($.eventName = \"DeleteBucketReplication\")) }"

      metric_transformation {
        name      = var.log_metric_filter_name_4_8
        namespace = "CISBenchmark"
        value     = "1"
      }
    }

    resource "aws_cloudwatch_metric_alarm" "log_metric_alarm_4_8" {
      alarm_name          = var.log_metric_alarm_name_4_8
      metric_name         = aws_cloudwatch_log_metric_filter.log_metric_filter_4_8.name
      namespace           = "CISBenchmark"
      statistic           = "Sum"
      period              = 300
      evaluation_periods  = 1
      threshold           = 1
      comparison_operator = "GreaterThanOrEqualToThreshold"
      alarm_actions       = [aws_sns_topic.metric_alarm_topic.arn] 
    }

    resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_4_9" {
      name           = var.log_metric_filter_name_4_9
      # Log Group from section 3.04
      log_group_name = aws_cloudwatch_log_group.log_group.name
      pattern        = "{ ($.eventSource = \"config.amazonaws.com\") && (($.eventName= \"StopConfigurationRecorder\") || ($.eventName= \"DeleteDeliveryChannel\") || ($.eventName= \"PutDeliveryChannel\") || ($.eventName= \"PutConfigurationRecorder\")) }"

      metric_transformation {
        name      = var.log_metric_filter_name_4_9
        namespace = "CISBenchmark"
        value     = "1"
      }
    }

    resource "aws_cloudwatch_metric_alarm" "log_metric_alarm_4_9" {
      alarm_name          = var.log_metric_alarm_name_4_9
      metric_name         = aws_cloudwatch_log_metric_filter.log_metric_filter_4_9.name
      namespace           = "CISBenchmark"
      statistic           = "Sum"
      period              = 300
      evaluation_periods  = 1
      threshold           = 1
      comparison_operator = "GreaterThanOrEqualToThreshold"
      alarm_actions       = [aws_sns_topic.metric_alarm_topic.arn] 
    }

    resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_4_10" {
      name           = var.log_metric_filter_name_4_10
      # Log Group from section 3.04
      log_group_name = aws_cloudwatch_log_group.log_group.name
      pattern        = "{ ($.eventName = \"AuthorizeSecurityGroupIngress\") || ($.eventName = \"AuthorizeSecurityGroupEgress\") || ($.eventName = \"RevokeSecurityGroupIngress\") || ($.eventName = \"RevokeSecurityGroupEgress\") || ($.eventName = \"CreateSecurityGroup\") || ($.eventName = \"DeleteSecurityGroup\") }"

      metric_transformation {
        name      = var.log_metric_filter_name_4_10
        namespace = "CISBenchmark"
        value     = "1"
      }
    }

    resource "aws_cloudwatch_metric_alarm" "log_metric_alarm_4_10" {
      alarm_name          = var.log_metric_alarm_name_4_10
      metric_name         = aws_cloudwatch_log_metric_filter.log_metric_filter_4_10.name
      namespace           = "CISBenchmark"
      statistic           = "Sum"
      period              = 300
      evaluation_periods  = 1
      threshold           = 1
      comparison_operator = "GreaterThanOrEqualToThreshold"
      alarm_actions       = [aws_sns_topic.metric_alarm_topic.arn] 
    }

    resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_4_11" {
      name           = var.log_metric_filter_name_4_11
      # Log Group from section 3.04
      log_group_name = aws_cloudwatch_log_group.log_group.name
      pattern        = "{ ($.eventName = \"CreateNetworkAcl\") || ($.eventName = \"CreateNetworkAclEntry\") || ($.eventName = \"DeleteNetworkAcl\") || ($.eventName = \"DeleteNetworkAclEntry\") || ($.eventName = \"ReplaceNetworkAclEntry\") || ($.eventName = \"ReplaceNetworkAclAssociation\") }"

      metric_transformation {
        name      = var.log_metric_filter_name_4_11
        namespace = "CISBenchmark"
        value     = "1"
      }
    }

    resource "aws_cloudwatch_metric_alarm" "log_metric_alarm_4_11" {
      alarm_name          = var.log_metric_alarm_name_4_11
      metric_name         = aws_cloudwatch_log_metric_filter.log_metric_filter_4_11.name
      namespace           = "CISBenchmark"
      statistic           = "Sum"
      period              = 300
      evaluation_periods  = 1
      threshold           = 1
      comparison_operator = "GreaterThanOrEqualToThreshold"
      alarm_actions       = [aws_sns_topic.metric_alarm_topic.arn] 
    }

    resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_4_12" {
      name           = var.log_metric_filter_name_4_12
      # Log Group from section 3.04
      log_group_name = aws_cloudwatch_log_group.log_group.name
      pattern        = "{ ($.eventName = \"CreateCustomerGateway\") || ($.eventName = \"DeleteCustomerGateway\") || ($.eventName = \"AttachInternetGateway\") || ($.eventName = \"CreateInternetGateway\") || ($.eventName = \"DeleteInternetGateway\") || ($.eventName = \"DetachInternetGateway\") }"

      metric_transformation {
        name      = var.log_metric_filter_name_4_12
        namespace = "CISBenchmark"
        value     = "1"
      }
    }

    resource "aws_cloudwatch_metric_alarm" "log_metric_alarm_4_12" {
      alarm_name          = var.log_metric_alarm_name_4_12
      metric_name         = aws_cloudwatch_log_metric_filter.log_metric_filter_4_12.name
      namespace           = "CISBenchmark"
      statistic           = "Sum"
      period              = 300
      evaluation_periods  = 1
      threshold           = 1
      comparison_operator = "GreaterThanOrEqualToThreshold"
      alarm_actions       = [aws_sns_topic.metric_alarm_topic.arn] 
    }

    resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_4_13" {
      name           = var.log_metric_filter_name_4_13
      # Log Group from section 3.04
      log_group_name = aws_cloudwatch_log_group.log_group.name
      pattern        = "{ ($.eventName = \"CreateRoute\") || ($.eventName = \"CreateRouteTable\") || ($.eventName = \"ReplaceRoute\") || ($.eventName = \"ReplaceRouteTableAssociation\") || ($.eventName = \"DeleteRouteTable\") || ($.eventName = \"DeleteRoute\") || ($.eventName = \"DisassociateRouteTable\") }"

      metric_transformation {
        name      = var.log_metric_filter_name_4_13
        namespace = "CISBenchmark"
        value     = "1"
      }
    }

    resource "aws_cloudwatch_metric_alarm" "log_metric_alarm_4_13" {
      alarm_name          = var.log_metric_alarm_name_4_13
      metric_name         = aws_cloudwatch_log_metric_filter.log_metric_filter_4_13.name
      namespace           = "CISBenchmark"
      statistic           = "Sum"
      period              = 300
      evaluation_periods  = 1
      threshold           = 1
      comparison_operator = "GreaterThanOrEqualToThreshold"
      alarm_actions       = [aws_sns_topic.metric_alarm_topic.arn] 
    }

    resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_4_14" {
      name           = var.log_metric_filter_name_4_14
      # Log Group from section 3.04
      log_group_name = aws_cloudwatch_log_group.log_group.name
      pattern        = "{ ($.eventName = \"CreateVpc\") || ($.eventName = \"DeleteVpc\") || ($.eventName = \"ModifyVpcAttribute\") || ($.eventName = \"AcceptVpcPeeringConnection\") || ($.eventName = \"CreateVpcPeeringConnection\") || ($.eventName = \"DeleteVpcPeeringConnection\") || ($.eventName = \"RejectVpcPeeringConnection\") || ($.eventName = \"AttachClassicLinkVpc\") || ($.eventName = \"DetachClassicLinkVp\") || ($.eventName = \"DisableVpcClassicLink\") || ($.eventName = \"EnableVpcClassicLink\") }"

      metric_transformation {
        name      = var.log_metric_filter_name_4_14
        namespace = "CISBenchmark"
        value     = "1"
      }
    }

    resource "aws_cloudwatch_metric_alarm" "log_metric_alarm_4_14" {
      alarm_name          = var.log_metric_alarm_name_4_14
      metric_name         = aws_cloudwatch_log_metric_filter.log_metric_filter_4_14.name
      namespace           = "CISBenchmark"
      statistic           = "Sum"
      period              = 300
      evaluation_periods  = 1
      threshold           = 1
      comparison_operator = "GreaterThanOrEqualToThreshold"
      alarm_actions       = [aws_sns_topic.metric_alarm_topic.arn] 
    }

    resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_4_15" {
      name           = var.log_metric_filter_name_4_15
      # Log Group from section 3.04
      log_group_name = aws_cloudwatch_log_group.log_group.name
      pattern        = "{ ($.eventSource = \"organizations.amazonaws.com\") && (($.eventName = \"AcceptHandshake\") || ($.eventName = \"AttachPolicy\") || ($.eventName = \"CreateAccount\") || ($.eventName = \"CreateOrganizationalUnit\") || ($.eventName = \"CreatePolicy\") || ($.eventName = \"DeclineHandshake\") || ($.eventName = \"DeleteOrganization\") || ($.eventName = \"DeleteOrganizationalUnit\") || ($.eventName = \"DeletePolicy\") || ($.eventName = \"DetachPolicy\") || ($.eventName = \"DisablePolicyType\") || ($.eventName = \"EnablePolicyType\") || ($.eventName = \"InviteAccountToOrganization\") || ($.eventName = \"LeaveOrganization\") || ($.eventName = \"MoveAccount\") || ($.eventName = \"RemoveAccountFromOrganization\") || ($.eventName = \"UpdatePolicy\") || ($.eventName = \"UpdateOrganizationalUnit\")) }"

      metric_transformation {
        name      = var.log_metric_filter_name_4_15
        namespace = "CISBenchmark"
        value     = "1"
      }
    }

    resource "aws_cloudwatch_metric_alarm" "log_metric_alarm_4_15" {
      alarm_name          = var.log_metric_alarm_name_4_15
      metric_name         = aws_cloudwatch_log_metric_filter.log_metric_filter_4_15.name
      namespace           = "CISBenchmark"
      statistic           = "Sum"
      period              = 300
      evaluation_periods  = 1
      threshold           = 1
      comparison_operator = "GreaterThanOrEqualToThreshold"
      alarm_actions       = [aws_sns_topic.metric_alarm_topic.arn] 
    }

    resource "aws_securityhub_account" "enable_security_hub" {
        enable_default_standards = var.enable_default_standards
    }
    EOT
}

# AWS > Region > Stack > Terraform Version
resource "turbot_policy_setting" "aws_region_stack_terraform_version" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws#/policy/types/regionStackTerraformVersion"
  note     = "AWS CIS v3.0.0 - Controls:  4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9, 4.10, 4.11, 4.12, 4.13, 4.14, 4.15, 4.16"
  value    = "0.15.*"
}