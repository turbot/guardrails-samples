# https://hub.guardrails.turbot.com/mods/aws/mods/aws
resource "turbot_mod" "aws" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "aws"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "aws") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-acm
resource "turbot_mod" "aws-acm" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-acm"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-acm") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-amplify
resource "turbot_mod" "aws-amplify" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-amplify"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-amplify") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-apigateway
resource "turbot_mod" "aws-apigateway" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-apigateway"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-apigateway") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-appconfig
resource "turbot_mod" "aws-appconfig" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-appconfig"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-appconfig") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-appfabric
resource "turbot_mod" "aws-appfabric" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-appfabric"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-appfabric") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-appflow
resource "turbot_mod" "aws-appflow" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-appflow"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-appflow") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-appmesh
resource "turbot_mod" "aws-appmesh" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-appmesh"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-appmesh") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-appstream
resource "turbot_mod" "aws-appstream" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-appstream"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-appstream") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-appsync
resource "turbot_mod" "aws-appsync" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-appsync"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-appsync") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-artifact
resource "turbot_mod" "aws-artifact" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-artifact"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-artifact") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-athena
resource "turbot_mod" "aws-athena" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-athena"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-athena") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-auditmanager
resource "turbot_mod" "aws-auditmanager" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-auditmanager"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-auditmanager") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-backup
resource "turbot_mod" "aws-backup" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-backup"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-backup") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-batch
resource "turbot_mod" "aws-batch" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-batch"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-batch") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-bedrock
resource "turbot_mod" "aws-bedrock" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-bedrock"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-bedrock") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-billing
resource "turbot_mod" "aws-billing" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-billing"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-billing") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-braket
resource "turbot_mod" "aws-braket" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-braket"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-braket") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-chatbot
resource "turbot_mod" "aws-chatbot" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-chatbot"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-chatbot") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-chime
resource "turbot_mod" "aws-chime" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-chime"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-chime") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-cisv1
resource "turbot_mod" "aws-cisv1" {
  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-cloudtrail,
    turbot_mod.aws-cloudwatch,
    turbot_mod.aws-config,
    turbot_mod.aws-ec2,
    turbot_mod.aws-iam,
    turbot_mod.aws-kms,
    turbot_mod.aws-logs,
    turbot_mod.aws-sns,
    turbot_mod.aws-vpc-core,
    turbot_mod.aws-vpc-security
  ]
  org     = "turbot"
  mod     = "aws-cisv1"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "aws-cisv1") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-cisv1-4
resource "turbot_mod" "aws-cisv1-4" {
  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-cloudtrail,
    turbot_mod.aws-cloudwatch,
    turbot_mod.aws-config,
    turbot_mod.aws-ec2,
    turbot_mod.aws-iam,
    turbot_mod.aws-kms,
    turbot_mod.aws-logs,
    turbot_mod.aws-rds,
    turbot_mod.aws-s3,
    turbot_mod.aws-sns,
    turbot_mod.aws-vpc-core,
    turbot_mod.aws-vpc-security
  ]
  org     = "turbot"
  mod     = "aws-cisv1-4"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "aws-cisv1-4") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-cisv2-0
resource "turbot_mod" "aws-cisv2-0" {
  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-cloudtrail,
    turbot_mod.aws-cloudwatch,
    turbot_mod.aws-config,
    turbot_mod.aws-ec2,
    turbot_mod.aws-efs,
    turbot_mod.aws-iam,
    turbot_mod.aws-kms,
    turbot_mod.aws-logs,
    turbot_mod.aws-rds,
    turbot_mod.aws-s3,
    turbot_mod.aws-securityhub,
    turbot_mod.aws-sns,
    turbot_mod.aws-vpc-core,
    turbot_mod.aws-vpc-security
  ]
  org     = "turbot"
  mod     = "aws-cisv2-0"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "aws-cisv2-0") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-cisv3-0
resource "turbot_mod" "aws-cisv3-0" {
  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-cloudtrail,
    turbot_mod.aws-cloudwatch,
    turbot_mod.aws-config,
    turbot_mod.aws-ec2,
    turbot_mod.aws-efs,
    turbot_mod.aws-iam,
    turbot_mod.aws-kms,
    turbot_mod.aws-logs,
    turbot_mod.aws-rds,
    turbot_mod.aws-s3,
    turbot_mod.aws-securityhub,
    turbot_mod.aws-sns,
    turbot_mod.aws-vpc-core,
    turbot_mod.aws-vpc-security
  ]
  org     = "turbot"
  mod     = "aws-cisv3-0"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "aws-cisv3-0") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-cleanrooms
resource "turbot_mod" "aws-cleanrooms" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-cleanrooms"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-cleanrooms") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-cloud9
resource "turbot_mod" "aws-cloud9" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-cloud9"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-cloud9") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-clouddirectory
resource "turbot_mod" "aws-clouddirectory" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-clouddirectory"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-clouddirectory") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-cloudformation
resource "turbot_mod" "aws-cloudformation" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-cloudformation"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-cloudformation") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-cloudfront
resource "turbot_mod" "aws-cloudfront" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-cloudfront"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-cloudfront") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-cloudhsm
resource "turbot_mod" "aws-cloudhsm" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-cloudhsm"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-cloudhsm") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-cloudmap
resource "turbot_mod" "aws-cloudmap" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-cloudmap"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-cloudmap") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-cloudsearch
resource "turbot_mod" "aws-cloudsearch" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-cloudsearch"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-cloudsearch") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-cloudshell
resource "turbot_mod" "aws-cloudshell" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-cloudshell"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-cloudshell") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-cloudtrail
resource "turbot_mod" "aws-cloudtrail" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-cloudtrail"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-cloudtrail") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-cloudwatch
resource "turbot_mod" "aws-cloudwatch" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-cloudwatch"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-cloudwatch") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-codebuild
resource "turbot_mod" "aws-codebuild" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-codebuild"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-codebuild") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-codecommit
resource "turbot_mod" "aws-codecommit" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-codecommit"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-codecommit") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-codedeploy
resource "turbot_mod" "aws-codedeploy" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-codedeploy"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-codedeploy") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-codepipeline
resource "turbot_mod" "aws-codepipeline" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-codepipeline"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-codepipeline") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-codestar
resource "turbot_mod" "aws-codestar" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-codestar"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-codestar") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-codewhisperer
resource "turbot_mod" "aws-codewhisperer" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-codewhisperer"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-codewhisperer") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-cognito
resource "turbot_mod" "aws-cognito" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-cognito"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-cognito") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-comprehend
resource "turbot_mod" "aws-comprehend" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-comprehend"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-comprehend") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-computeoptimizer
resource "turbot_mod" "aws-computeoptimizer" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-computeoptimizer"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-computeoptimizer") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-config
resource "turbot_mod" "aws-config" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-config"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-config") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-connect
resource "turbot_mod" "aws-connect" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-connect"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-connect") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-datapipeline
resource "turbot_mod" "aws-datapipeline" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-datapipeline"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-datapipeline") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-datasync
resource "turbot_mod" "aws-datasync" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-datasync"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-datasync") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-dax
resource "turbot_mod" "aws-dax" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-dax"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-dax") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-devicefarm
resource "turbot_mod" "aws-devicefarm" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-devicefarm"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-devicefarm") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-directconnect
resource "turbot_mod" "aws-directconnect" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-directconnect"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-directconnect") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-directoryservice
resource "turbot_mod" "aws-directoryservice" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-directoryservice"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-directoryservice") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-dms
resource "turbot_mod" "aws-dms" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-kms]
  org        = "turbot"
  mod        = "aws-dms"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-dms") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-docdb
resource "turbot_mod" "aws-docdb" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-rds]
  org        = "turbot"
  mod        = "aws-docdb"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-docdb") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-dynamodb
resource "turbot_mod" "aws-dynamodb" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-dynamodb"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-dynamodb") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-ec2
resource "turbot_mod" "aws-ec2" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-kms]
  org        = "turbot"
  mod        = "aws-ec2"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-ec2") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-ec2imagebuilder
resource "turbot_mod" "aws-ec2imagebuilder" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-ec2imagebuilder"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-ec2imagebuilder") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-ecr
resource "turbot_mod" "aws-ecr" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-ecr"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-ecr") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-ecs
resource "turbot_mod" "aws-ecs" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-ecs"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-ecs") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-efs
resource "turbot_mod" "aws-efs" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-efs"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-efs") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-eks
resource "turbot_mod" "aws-eks" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-eks"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-eks") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-elasticache
resource "turbot_mod" "aws-elasticache" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-elasticache"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-elasticache") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-elasticbeanstalk
resource "turbot_mod" "aws-elasticbeanstalk" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-elasticbeanstalk"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-elasticbeanstalk") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-elasticinference
resource "turbot_mod" "aws-elasticinference" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-elasticinference"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-elasticinference") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-elasticsearch
resource "turbot_mod" "aws-elasticsearch" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-elasticsearch"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-elasticsearch") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-elastictranscoder
resource "turbot_mod" "aws-elastictranscoder" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-elastictranscoder"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-elastictranscoder") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-emr
resource "turbot_mod" "aws-emr" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-emr"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-emr") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-eventbridgepipes
resource "turbot_mod" "aws-eventbridgepipes" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-eventbridgepipes"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-eventbridgepipes") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-eventbridgescheduler
resource "turbot_mod" "aws-eventbridgescheduler" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-eventbridgescheduler"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-eventbridgescheduler") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-events
resource "turbot_mod" "aws-events" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-events"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-events") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-fms
resource "turbot_mod" "aws-fms" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-fms"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-fms") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-fsx
resource "turbot_mod" "aws-fsx" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-fsx"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-fsx") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-gamelift
resource "turbot_mod" "aws-gamelift" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-gamelift"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-gamelift") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-glacier
resource "turbot_mod" "aws-glacier" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-glacier"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-glacier") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-globalaccelerator
resource "turbot_mod" "aws-globalaccelerator" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-globalaccelerator"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-globalaccelerator") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-glue
resource "turbot_mod" "aws-glue" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-glue"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-glue") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-gluedatabrew
resource "turbot_mod" "aws-gluedatabrew" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-gluedatabrew"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-gluedatabrew") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-greengrass
resource "turbot_mod" "aws-greengrass" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-greengrass"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-greengrass") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-guardduty
resource "turbot_mod" "aws-guardduty" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-guardduty"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-guardduty") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-health
resource "turbot_mod" "aws-health" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-health"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-health") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-hipaa
resource "turbot_mod" "aws-hipaa" {
  parent = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws,
    turbot_mod.aws-acm,
    turbot_mod.aws-apigateway,
    turbot_mod.aws-backup,
    turbot_mod.aws-cloudfront,
    turbot_mod.aws-cloudtrail,
    turbot_mod.aws-cloudwatch,
    turbot_mod.aws-codebuild,
    turbot_mod.aws-dax,
    turbot_mod.aws-dms,
    turbot_mod.aws-dynamodb,
    turbot_mod.aws-ec2,
    turbot_mod.aws-efs,
    turbot_mod.aws-eks,
    turbot_mod.aws-elasticache,
    turbot_mod.aws-elasticsearch,
    turbot_mod.aws-emr,
    turbot_mod.aws-fsx,
    turbot_mod.aws-guardduty,
    turbot_mod.aws-iam,
    turbot_mod.aws-kms,
    turbot_mod.aws-lambda,
    turbot_mod.aws-logs,
    turbot_mod.aws-rds,
    turbot_mod.aws-redshift,
    turbot_mod.aws-s3,
    turbot_mod.aws-sagemaker,
    turbot_mod.aws-secretsmanager,
    turbot_mod.aws-sns,
    turbot_mod.aws-ssm,
    turbot_mod.aws-vpc-connect,
    turbot_mod.aws-vpc-core,
    turbot_mod.aws-vpc-internet,
    turbot_mod.aws-vpc-security,
    turbot_mod.aws-waf
  ]
  org     = "turbot"
  mod     = "aws-hipaa"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "aws-hipaa") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-iam
resource "turbot_mod" "aws-iam" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws]
  org        = "turbot"
  mod        = "aws-iam"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-iam") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-inspector
resource "turbot_mod" "aws-inspector" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-inspector"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-inspector") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-iot
resource "turbot_mod" "aws-iot" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-iot"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-iot") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-iot1click
resource "turbot_mod" "aws-iot1click" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-iot1click"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-iot1click") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-iotanalytics
resource "turbot_mod" "aws-iotanalytics" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-iotanalytics"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-iotanalytics") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-iotevents
resource "turbot_mod" "aws-iotevents" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-iotevents"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-iotevents") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-iotsitewise
resource "turbot_mod" "aws-iotsitewise" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-iotsitewise"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-iotsitewise") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-iotthingsgraph
resource "turbot_mod" "aws-iotthingsgraph" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-iotthingsgraph"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-iotthingsgraph") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-kendra
resource "turbot_mod" "aws-kendra" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-kendra"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-kendra") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-kinesis
resource "turbot_mod" "aws-kinesis" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-kinesis"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-kinesis") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-kms
resource "turbot_mod" "aws-kms" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-kms"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-kms") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-lakeformation
resource "turbot_mod" "aws-lakeformation" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-lakeformation"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-lakeformation") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-lambda
resource "turbot_mod" "aws-lambda" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-lambda"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-lambda") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-lex
resource "turbot_mod" "aws-lex" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-lex"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-lex") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-lightsail
resource "turbot_mod" "aws-lightsail" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-lightsail"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-lightsail") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-location
resource "turbot_mod" "aws-location" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-location"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-location") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-logs
resource "turbot_mod" "aws-logs" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-logs"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-logs") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-machinelearning
resource "turbot_mod" "aws-machinelearning" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-machinelearning"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-machinelearning") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-macie
resource "turbot_mod" "aws-macie" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-macie"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-macie") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-mediaconnect
resource "turbot_mod" "aws-mediaconnect" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-mediaconnect"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-mediaconnect") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-mediaconvert
resource "turbot_mod" "aws-mediaconvert" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-mediaconvert"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-mediaconvert") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-medialive
resource "turbot_mod" "aws-medialive" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-medialive"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-medialive") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-mediapackage
resource "turbot_mod" "aws-mediapackage" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-mediapackage"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-mediapackage") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-mediastore
resource "turbot_mod" "aws-mediastore" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-mediastore"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-mediastore") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-mediatailor
resource "turbot_mod" "aws-mediatailor" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-mediatailor"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-mediatailor") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-mq
resource "turbot_mod" "aws-mq" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-mq"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-mq") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-msk
resource "turbot_mod" "aws-msk" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-msk"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-msk") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-mwaa
resource "turbot_mod" "aws-mwaa" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-mwaa"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-mwaa") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-neptune
resource "turbot_mod" "aws-neptune" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-rds]
  org        = "turbot"
  mod        = "aws-neptune"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-neptune") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-nist-800-53
resource "turbot_mod" "aws-nist-800-53" {
  parent = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws,
    turbot_mod.aws-acm,
    turbot_mod.aws-apigateway,
    turbot_mod.aws-cloudtrail,
    turbot_mod.aws-cloudwatch,
    turbot_mod.aws-codebuild,
    turbot_mod.aws-dms,
    turbot_mod.aws-dynamodb,
    turbot_mod.aws-ec2,
    turbot_mod.aws-ecs,
    turbot_mod.aws-efs,
    turbot_mod.aws-elasticache,
    turbot_mod.aws-elasticsearch,
    turbot_mod.aws-emr,
    turbot_mod.aws-guardduty,
    turbot_mod.aws-iam,
    turbot_mod.aws-kms,
    turbot_mod.aws-lambda,
    turbot_mod.aws-logs,
    turbot_mod.aws-rds,
    turbot_mod.aws-redshift,
    turbot_mod.aws-s3,
    turbot_mod.aws-sagemaker,
    turbot_mod.aws-secretsmanager,
    turbot_mod.aws-securityhub,
    turbot_mod.aws-sns,
    turbot_mod.aws-ssm,
    turbot_mod.aws-vpc-connect,
    turbot_mod.aws-vpc-core,
    turbot_mod.aws-vpc-internet,
    turbot_mod.aws-vpc-security,
    turbot_mod.aws-waf
  ]
  org     = "turbot"
  mod     = "aws-nist-800-53"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "aws-nist-800-53") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-omics
resource "turbot_mod" "aws-omics" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-omics"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-omics") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-opensearch
resource "turbot_mod" "aws-opensearch" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-opensearch"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-opensearch") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-organizations
resource "turbot_mod" "aws-organizations" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-organizations"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-organizations") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-outposts
resource "turbot_mod" "aws-outposts" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-outposts"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-outposts") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-pciv3-2-1
resource "turbot_mod" "aws-pciv3-2-1" {
  parent = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws,
    turbot_mod.aws-cloudtrail,
    turbot_mod.aws-codebuild,
    turbot_mod.aws-dms,
    turbot_mod.aws-ec2,
    turbot_mod.aws-elasticsearch,
    turbot_mod.aws-guardduty,
    turbot_mod.aws-iam,
    turbot_mod.aws-kms,
    turbot_mod.aws-lambda,
    turbot_mod.aws-rds,
    turbot_mod.aws-redshift,
    turbot_mod.aws-s3,
    turbot_mod.aws-sagemaker,
    turbot_mod.aws-ssm,
    turbot_mod.aws-vpc-core,
    turbot_mod.aws-vpc-internet,
    turbot_mod.aws-vpc-security
  ]
  org     = "turbot"
  mod     = "aws-pciv3-2-1"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "aws-pciv3-2-1") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-polly
resource "turbot_mod" "aws-polly" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-polly"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-polly") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-qldb
resource "turbot_mod" "aws-qldb" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-qldb"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-qldb") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-quicksight
resource "turbot_mod" "aws-quicksight" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-quicksight"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-quicksight") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-ram
resource "turbot_mod" "aws-ram" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-ram"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-ram") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-rds
resource "turbot_mod" "aws-rds" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-rds"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-rds") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-redshift
resource "turbot_mod" "aws-redshift" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-redshift"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-redshift") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-redshiftserverless
resource "turbot_mod" "aws-redshiftserverless" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-redshiftserverless"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-redshiftserverless") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-rekognition
resource "turbot_mod" "aws-rekognition" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-rekognition"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-rekognition") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-resourcegroups
resource "turbot_mod" "aws-resourcegroups" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-resourcegroups"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-resourcegroups") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-robomaker
resource "turbot_mod" "aws-robomaker" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-robomaker"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-robomaker") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-route53
resource "turbot_mod" "aws-route53" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-route53"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-route53") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-route53domains
resource "turbot_mod" "aws-route53domains" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-route53domains"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-route53domains") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-route53recoverycontrolconfig
resource "turbot_mod" "aws-route53recoverycontrolconfig" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-route53recoverycontrolconfig"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-route53recoverycontrolconfig") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-route53recoveryreadiness
resource "turbot_mod" "aws-route53recoveryreadiness" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-route53recoveryreadiness"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-route53recoveryreadiness") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-route53resolver
resource "turbot_mod" "aws-route53resolver" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-route53resolver"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-route53resolver") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-s3
resource "turbot_mod" "aws-s3" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-kms]
  org        = "turbot"
  mod        = "aws-s3"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-s3") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-s3multiregionaccesspoint
resource "turbot_mod" "aws-s3multiregionaccesspoint" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-s3]
  org        = "turbot"
  mod        = "aws-s3multiregionaccesspoint"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-s3multiregionaccesspoint") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-sagemaker
resource "turbot_mod" "aws-sagemaker" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-sagemaker"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-sagemaker") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-savingsplans
resource "turbot_mod" "aws-savingsplans" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-savingsplans"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-savingsplans") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-scheduler
resource "turbot_mod" "aws-scheduler" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-scheduler"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-scheduler") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-secretsmanager
resource "turbot_mod" "aws-secretsmanager" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-secretsmanager"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-secretsmanager") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-securityhub
resource "turbot_mod" "aws-securityhub" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-securityhub"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-securityhub") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-serverlessapplicationrepository
resource "turbot_mod" "aws-serverlessapplicationrepository" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-serverlessapplicationrepository"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-serverlessapplicationrepository") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-servermigration
resource "turbot_mod" "aws-servermigration" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-servermigration"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-servermigration") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-servicecatalog
resource "turbot_mod" "aws-servicecatalog" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-servicecatalog"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-servicecatalog") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-servicequotas
resource "turbot_mod" "aws-servicequotas" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-servicequotas"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-servicequotas") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-ses
resource "turbot_mod" "aws-ses" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-ses"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-ses") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-shield
resource "turbot_mod" "aws-shield" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-shield"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-shield") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-signer
resource "turbot_mod" "aws-signer" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-signer"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-signer") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-simpledb
resource "turbot_mod" "aws-simpledb" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-simpledb"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-simpledb") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-snowball
resource "turbot_mod" "aws-snowball" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-snowball"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-snowball") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-sns
resource "turbot_mod" "aws-sns" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-sns"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-sns") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-sqs
resource "turbot_mod" "aws-sqs" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-sqs"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-sqs") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-ssm
resource "turbot_mod" "aws-ssm" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-ssm"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-ssm") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-stepfunctions
resource "turbot_mod" "aws-stepfunctions" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-stepfunctions"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-stepfunctions") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-storagegateway
resource "turbot_mod" "aws-storagegateway" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-storagegateway"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-storagegateway") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-swf
resource "turbot_mod" "aws-swf" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-swf"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-swf") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-tagging
resource "turbot_mod" "aws-tagging" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-tagging"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-tagging") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-textract
resource "turbot_mod" "aws-textract" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-textract"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-textract") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-transcribe
resource "turbot_mod" "aws-transcribe" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-transcribe"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-transcribe") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-transfer
resource "turbot_mod" "aws-transfer" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-transfer"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-transfer") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-translate
resource "turbot_mod" "aws-translate" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-translate"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-translate") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-trustedadvisor
resource "turbot_mod" "aws-trustedadvisor" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-trustedadvisor"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-trustedadvisor") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-vpc-connect
resource "turbot_mod" "aws-vpc-connect" {
  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-ec2,
    turbot_mod.aws-iam,
    turbot_mod.aws-kms,
    turbot_mod.aws-vpc-core
  ]
  org     = "turbot"
  mod     = "aws-vpc-connect"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "aws-vpc-connect") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-vpc-core
resource "turbot_mod" "aws-vpc-core" {
  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-ec2,
    turbot_mod.aws-iam,
    turbot_mod.aws-kms
  ]
  org     = "turbot"
  mod     = "aws-vpc-core"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "aws-vpc-core") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-vpc-internet
resource "turbot_mod" "aws-vpc-internet" {
  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-ec2,
    turbot_mod.aws-iam,
    turbot_mod.aws-kms,
    turbot_mod.aws-vpc-core
  ]
  org     = "turbot"
  mod     = "aws-vpc-internet"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "aws-vpc-internet") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-vpc-security
resource "turbot_mod" "aws-vpc-security" {
  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-ec2,
    turbot_mod.aws-iam,
    turbot_mod.aws-kms,
    turbot_mod.aws-vpc-core
  ]
  org     = "turbot"
  mod     = "aws-vpc-security"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "aws-vpc-security") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-vpclattice
resource "turbot_mod" "aws-vpclattice" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-vpclattice"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-vpclattice") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-waf
resource "turbot_mod" "aws-waf" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-waf"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-waf") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-wafregional
resource "turbot_mod" "aws-wafregional" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-wafregional"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-wafregional") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-wellarchitected
resource "turbot_mod" "aws-wellarchitected" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-wellarchitected"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-wellarchitected") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-wellarchitected-framework
resource "turbot_mod" "aws-wellarchitected-framework" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-wellarchitected]
  org        = "turbot"
  mod        = "aws-wellarchitected-framework"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-wellarchitected-framework") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-workdocs
resource "turbot_mod" "aws-workdocs" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-workdocs"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-workdocs") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-workspaces
resource "turbot_mod" "aws-workspaces" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-workspaces"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-workspaces") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/aws/mods/aws-xray
resource "turbot_mod" "aws-xray" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-xray"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "aws-xray") ? 1 : 0
}
