# https://turbot.com/v5/mods/turbot/aws
resource "turbot_mod" "aws" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "aws"
  version = ">=5.0.0-beta.1"
  count   = contains(var.mod_list, "aws") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-acm
resource "turbot_mod" "aws-acm" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-acm"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-acm") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-amplify
resource "turbot_mod" "aws-amplify" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-amplify"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-amplify") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-apigateway
resource "turbot_mod" "aws-apigateway" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-apigateway"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-apigateway") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-appflow
resource "turbot_mod" "aws-appflow" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-appflow"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-appflow") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-appmesh
resource "turbot_mod" "aws-appmesh" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-appmesh"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-appmesh") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-appstream
resource "turbot_mod" "aws-appstream" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-appstream"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-appstream") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-appsync
resource "turbot_mod" "aws-appsync" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-appsync"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-appsync") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-artifact
resource "turbot_mod" "aws-artifact" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-artifact"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-artifact") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-athena
resource "turbot_mod" "aws-athena" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-athena"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-athena") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-backup
resource "turbot_mod" "aws-backup" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-backup"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-backup") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-batch
resource "turbot_mod" "aws-batch" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-batch"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-batch") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-chime
resource "turbot_mod" "aws-chime" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-chime"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-chime") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-cisv1
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
  version = ">=5.0.0-beta.1"
  count   = contains(var.mod_list, "aws-cisv1") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-cloud9
resource "turbot_mod" "aws-cloud9" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-cloud9"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-cloud9") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-cloudformation
resource "turbot_mod" "aws-cloudformation" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-cloudformation"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-cloudformation") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-cloudfront
resource "turbot_mod" "aws-cloudfront" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-cloudfront"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-cloudfront") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-cloudhsm
resource "turbot_mod" "aws-cloudhsm" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-cloudhsm"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-cloudhsm") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-cloudsearch
resource "turbot_mod" "aws-cloudsearch" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-cloudsearch"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-cloudsearch") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-cloudtrail
resource "turbot_mod" "aws-cloudtrail" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-cloudtrail"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-cloudtrail") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-cloudwatch
resource "turbot_mod" "aws-cloudwatch" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-cloudwatch"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-cloudwatch") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-codebuild
resource "turbot_mod" "aws-codebuild" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-codebuild"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-codebuild") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-codecommit
resource "turbot_mod" "aws-codecommit" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-codecommit"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-codecommit") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-codedeploy
resource "turbot_mod" "aws-codedeploy" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-codedeploy"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-codedeploy") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-codepipeline
resource "turbot_mod" "aws-codepipeline" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-codepipeline"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-codepipeline") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-codestar
resource "turbot_mod" "aws-codestar" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-codestar"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-codestar") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-comprehend
resource "turbot_mod" "aws-comprehend" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-comprehend"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-comprehend") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-config
resource "turbot_mod" "aws-config" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-config"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-config") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-datapipeline
resource "turbot_mod" "aws-datapipeline" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-datapipeline"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-datapipeline") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-dax
resource "turbot_mod" "aws-dax" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-dax"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-dax") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-directoryservice
resource "turbot_mod" "aws-directoryservice" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-directoryservice"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-directoryservice") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-dms
resource "turbot_mod" "aws-dms" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-dms"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-dms") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-docdb
resource "turbot_mod" "aws-docdb" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-rds]
  org        = "turbot"
  mod        = "aws-docdb"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-docdb") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-dynamodb
resource "turbot_mod" "aws-dynamodb" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-dynamodb"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-dynamodb") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-ec2
resource "turbot_mod" "aws-ec2" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-kms]
  org        = "turbot"
  mod        = "aws-ec2"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-ec2") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-ecr
resource "turbot_mod" "aws-ecr" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-ecr"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-ecr") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-ecs
resource "turbot_mod" "aws-ecs" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-ecs"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-ecs") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-efs
resource "turbot_mod" "aws-efs" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-efs"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-efs") ? 1 : 0
}
# https://turbot.com/v5/mods/turbot/aws-eks
resource "turbot_mod" "aws-eks" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-eks"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-eks") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-elasticache
resource "turbot_mod" "aws-elasticache" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-elasticache"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-elasticache") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-elasticbeanstalk
resource "turbot_mod" "aws-elasticbeanstalk" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-elasticbeanstalk"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-elasticbeanstalk") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-elasticsearch
resource "turbot_mod" "aws-elasticsearch" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-elasticsearch"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-elasticsearch") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-elastictranscoder
resource "turbot_mod" "aws-elastictranscoder" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-elastictranscoder"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-elastictranscoder") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-emr
resource "turbot_mod" "aws-emr" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-emr"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-emr") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-events
resource "turbot_mod" "aws-events" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-events"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-events") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-fsx
resource "turbot_mod" "aws-fsx" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-fsx"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-fsx") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-gamelift
resource "turbot_mod" "aws-gamelift" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-gamelift"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-gamelift") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-glacier
resource "turbot_mod" "aws-glacier" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-glacier"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-glacier") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-glue
resource "turbot_mod" "aws-glue" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-glue"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-glue") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-greengrass
resource "turbot_mod" "aws-greengrass" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-greengrass"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-greengrass") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-guardduty
resource "turbot_mod" "aws-guardduty" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-guardduty"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-guardduty") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-health
resource "turbot_mod" "aws-health" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-health"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-health") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-iam
resource "turbot_mod" "aws-iam" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws]
  org        = "turbot"
  mod        = "aws-iam"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-iam") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-inspector
resource "turbot_mod" "aws-inspector" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-inspector"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-inspector") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-iot
resource "turbot_mod" "aws-iot" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-iot"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-iot") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-iot1click
resource "turbot_mod" "aws-iot1click" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-iot1click"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-iot1click") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-iotanalytics
resource "turbot_mod" "aws-iotanalytics" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-iotanalytics"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-iotanalytics") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-iotevents
resource "turbot_mod" "aws-iotevents" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-iotevents"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-iotevents") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-iotsitewise
resource "turbot_mod" "aws-iotsitewise" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-iotsitewise"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-iotsitewise") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-iotthingsgraph
resource "turbot_mod" "aws-iotthingsgraph" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-iotthingsgraph"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-iotthingsgraph") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-kinesis
resource "turbot_mod" "aws-kinesis" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-kinesis"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-kinesis") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-kms
resource "turbot_mod" "aws-kms" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-kms"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-kms") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-lambda
resource "turbot_mod" "aws-lambda" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-lambda"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-lambda") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-lex
resource "turbot_mod" "aws-lex" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-lex"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-lex") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-lightsail
resource "turbot_mod" "aws-lightsail" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-lightsail"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-lightsail") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-logs
resource "turbot_mod" "aws-logs" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-logs"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-logs") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-machinelearning
resource "turbot_mod" "aws-machinelearning" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-machinelearning"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-machinelearning") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-macie
resource "turbot_mod" "aws-macie" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-macie"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-macie") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-mediaconnect
resource "turbot_mod" "aws-mediaconnect" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-mediaconnect"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-mediaconnect") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-mediaconvert
resource "turbot_mod" "aws-mediaconvert" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-mediaconvert"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-mediaconvert") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-medialive
resource "turbot_mod" "aws-medialive" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-medialive"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-medialive") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-mediapackage
resource "turbot_mod" "aws-mediapackage" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-mediapackage"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-mediapackage") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-mediastore
resource "turbot_mod" "aws-mediastore" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-mediastore"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-mediastore") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-mediatailor
resource "turbot_mod" "aws-mediatailor" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-mediatailor"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-mediatailor") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-mq
resource "turbot_mod" "aws-mq" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-mq"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-mq") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-msk
resource "turbot_mod" "aws-msk" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-msk"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-msk") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-neptune
resource "turbot_mod" "aws-neptune" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-rds]
  org        = "turbot"
  mod        = "aws-neptune"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-neptune") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-outposts
resource "turbot_mod" "aws-outposts" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-rds]
  org        = "turbot"
  mod        = "aws-outposts"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-outposts") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-qldb
resource "turbot_mod" "aws-qldb" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-qldb"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-qldb") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-quicksight
resource "turbot_mod" "aws-quicksight" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-quicksight"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-quicksight") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-ram
resource "turbot_mod" "aws-ram" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-ram"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-ram") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-rds
resource "turbot_mod" "aws-rds" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-rds"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-rds") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-redshift
resource "turbot_mod" "aws-redshift" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-ec2]
  org        = "turbot"
  mod        = "aws-redshift"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-redshift") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-resourcegroups
resource "turbot_mod" "aws-resourcegroups" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-ec2]
  org        = "turbot"
  mod        = "aws-resourcegroups"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-resourcegroups") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-robomaker
resource "turbot_mod" "aws-robomaker" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-robomaker"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-robomaker") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-route53
resource "turbot_mod" "aws-route53" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-route53"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-route53") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-route53domains
resource "turbot_mod" "aws-route53domains" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-route53domains"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-route53domains") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-route53resolver
resource "turbot_mod" "aws-route53resolver" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-route53resolver"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-route53resolver") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-s3
resource "turbot_mod" "aws-s3" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-kms]
  org        = "turbot"
  mod        = "aws-s3"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-s3") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-sagemaker
resource "turbot_mod" "aws-sagemaker" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-sagemaker"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-sagemaker") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-secretsmanager
resource "turbot_mod" "aws-secretsmanager" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-secretsmanager"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-secretsmanager") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-securityhub
resource "turbot_mod" "aws-securityhub" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-securityhub"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-securityhub") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-serverlessapplicationrepository
resource "turbot_mod" "aws-serverlessapplicationrepository" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-serverlessapplicationrepository"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-serverlessapplicationrepository") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-servermigration
resource "turbot_mod" "aws-servermigration" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-servermigration"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-servermigration") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-servicecatalog
resource "turbot_mod" "aws-servicecatalog" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-servicecatalog"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-servicecatalog") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-ses
resource "turbot_mod" "aws-ses" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-ses"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-ses") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-shield
resource "turbot_mod" "aws-shield" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-shield"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-shield") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-simpledb
resource "turbot_mod" "aws-simpledb" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-simpledb"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-simpledb") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-snowball
resource "turbot_mod" "aws-snowball" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-snowball"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-snowball") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-sns
resource "turbot_mod" "aws-sns" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam]
  org        = "turbot"
  mod        = "aws-sns"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-sns") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-sqs
resource "turbot_mod" "aws-sqs" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-sqs"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-sqs") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-ssm
resource "turbot_mod" "aws-ssm" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-ssm"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-ssm") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-stepfunctions
resource "turbot_mod" "aws-stepfunctions" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-stepfunctions"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-stepfunctions") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-storagegateway
resource "turbot_mod" "aws-storagegateway" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-storagegateway"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-storagegateway") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-swf
resource "turbot_mod" "aws-swf" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-swf"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-swf") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-textract
resource "turbot_mod" "aws-textract" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-textract"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-textract") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-transcribe
resource "turbot_mod" "aws-transcribe" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-transcribe"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-transcribe") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-transfer
resource "turbot_mod" "aws-transfer" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-transfer"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-transfer") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-trustedadvisor
resource "turbot_mod" "aws-trustedadvisor" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-trustedadvisor"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-trustedadvisor") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-vpc-connect
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
  version = ">=5.0.0-beta.1"
  count   = contains(var.mod_list, "aws-vpc-connect") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-vpc-core
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
  version = ">=5.0.0-beta.1"
  count   = contains(var.mod_list, "aws-vpc-core") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-vpc-internet
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
  version = ">=5.0.0-beta.1"
  count   = contains(var.mod_list, "aws-vpc-internet") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-vpc-security
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
  version = ">=5.0.0-beta.1"
  count   = contains(var.mod_list, "aws-vpc-security") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-waf
resource "turbot_mod" "aws-waf" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-cisv1]
  org        = "turbot"
  mod        = "aws-waf"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-waf") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-wafregional
resource "turbot_mod" "aws-wafregional" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-wafregional"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-wafregional") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-wellarchitected
resource "turbot_mod" "aws-wellarchitected" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-wellarchitected"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-wellarchitected") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-workspaces
resource "turbot_mod" "aws-workspaces" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-workspaces"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-workspaces") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-workdocs
resource "turbot_mod" "aws-workdocs" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-workdocs"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-workdocs") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/aws-xray
resource "turbot_mod" "aws-xray" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-waf]
  org        = "turbot"
  mod        = "aws-xray"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "aws-xray") ? 1 : 0
}
