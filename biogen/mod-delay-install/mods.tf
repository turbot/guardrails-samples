# Install mod - turbot
resource "turbot_mod" "turbot" {
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "turbot"
}

# Back off timer - turbot
resource "time_sleep" "turbot_wait_300_seconds" {
  # After turbot mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.turbot]
  create_duration = var.backoff_duration
}

# Install mod - turbot-iam
resource "turbot_mod" "turbot_iam" {
  # Wait for turbot timer to run out
  depends_on = [time_sleep.turbot_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "turbot-iam"
}

# Back off timer - turbot-iam
resource "time_sleep" "turbot_iam_wait_300_seconds" {
  # After turbot-iam mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.turbot_iam]
  create_duration = var.backoff_duration
}

# Install mod - aws
resource "turbot_mod" "aws" {
  # Wait for turbot-iam timer to run out
  depends_on = [time_sleep.turbot_iam_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws"
}

# Back off timer - aws
resource "time_sleep" "aws_wait_300_seconds" {
  # After aws mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws]
  create_duration = var.backoff_duration
}

# Install mod - aws-iam
resource "turbot_mod" "aws_iam" {
  # Wait for aws timer to run out
  depends_on = [time_sleep.aws_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-iam"
}

# Back off timer - aws-iam
resource "time_sleep" "aws_iam_wait_300_seconds" {
  # After aws-iam mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_iam]
  create_duration = var.backoff_duration
}

# Install mod - aws-acm
resource "turbot_mod" "aws_acm" {
  # Wait for aws-iam timer to run out
  depends_on = [time_sleep.aws_iam_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-acm"
}

# Back off timer - aws-acm
resource "time_sleep" "aws_acm_wait_300_seconds" {
  # After aws-acm mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_acm]
  create_duration = var.backoff_duration
}

# Install mod - aws-amplify
resource "turbot_mod" "aws_amplify" {
  # Wait for aws-acm timer to run out
  depends_on = [time_sleep.aws_acm_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-amplify"
}

# Back off timer - aws-amplify
resource "time_sleep" "aws_amplify_wait_300_seconds" {
  # After aws-amplify mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_amplify]
  create_duration = var.backoff_duration
}

# Install mod - aws-apigateway
resource "turbot_mod" "aws_apigateway" {
  # Wait for aws-amplify timer to run out
  depends_on = [time_sleep.aws_amplify_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-apigateway"
}

# Back off timer - aws-apigateway
resource "time_sleep" "aws_apigateway_wait_300_seconds" {
  # After aws-apigateway mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_apigateway]
  create_duration = var.backoff_duration
}

# Install mod - aws-appstream
resource "turbot_mod" "aws_appstream" {
  # Wait for aws-apigateway timer to run out
  depends_on = [time_sleep.aws_apigateway_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-appstream"
}

# Back off timer - aws-appstream
resource "time_sleep" "aws_appstream_wait_300_seconds" {
  # After aws-appstream mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_appstream]
  create_duration = var.backoff_duration
}

# Install mod - aws-appsync
resource "turbot_mod" "aws_appsync" {
  # Wait for aws-appstream timer to run out
  depends_on = [time_sleep.aws_appstream_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-appsync"
}

# Back off timer - aws-appsync
resource "time_sleep" "aws_appsync_wait_300_seconds" {
  # After aws-appsync mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_appsync]
  create_duration = var.backoff_duration
}

# Install mod - aws-athena
resource "turbot_mod" "aws_athena" {
  # Wait for aws-appsync timer to run out
  depends_on = [time_sleep.aws_appsync_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-athena"
}

# Back off timer - aws-athena
resource "time_sleep" "aws_athena_wait_300_seconds" {
  # After aws-athena mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_athena]
  create_duration = var.backoff_duration
}

# Install mod - aws-batch
resource "turbot_mod" "aws_batch" {
  # Wait for aws-athena timer to run out
  depends_on = [time_sleep.aws_athena_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-batch"
}

# Back off timer - aws-batch
resource "time_sleep" "aws_batch_wait_300_seconds" {
  # After aws-batch mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_batch]
  create_duration = var.backoff_duration
}

# Install mod - aws-billing
resource "turbot_mod" "aws_billing" {
  # Wait for aws-batch timer to run out
  depends_on = [time_sleep.aws_batch_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-billing"
}

# Back off timer - aws-billing
resource "time_sleep" "aws_billing_wait_300_seconds" {
  # After aws-billing mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_billing]
  create_duration = var.backoff_duration
}

# Install mod - aws-chatbot
resource "turbot_mod" "aws_chatbot" {
  # Wait for aws-billing timer to run out
  depends_on = [time_sleep.aws_billing_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-chatbot"
}

# Back off timer - aws-chatbot
resource "time_sleep" "aws_chatbot_wait_300_seconds" {
  # After aws-chatbot mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_chatbot]
  create_duration = var.backoff_duration
}

# Install mod - aws-cloud9
resource "turbot_mod" "aws_cloud9" {
  # Wait for aws-chatbot timer to run out
  depends_on = [time_sleep.aws_chatbot_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-cloud9"
}

# Back off timer - aws-cloud9
resource "time_sleep" "aws_cloud9_wait_300_seconds" {
  # After aws-cloud9 mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_cloud9]
  create_duration = var.backoff_duration
}

# Install mod - aws-clouddirectory
resource "turbot_mod" "aws_clouddirectory" {
  # Wait for aws-cloud9 timer to run out
  depends_on = [time_sleep.aws_cloud9_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-clouddirectory"
}

# Back off timer - aws-clouddirectory
resource "time_sleep" "aws_clouddirectory_wait_300_seconds" {
  # After aws-clouddirectory mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_clouddirectory]
  create_duration = var.backoff_duration
}

# Install mod - aws-cloudformation
resource "turbot_mod" "aws_cloudformation" {
  # Wait for aws-clouddirectory timer to run out
  depends_on = [time_sleep.aws_clouddirectory_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-cloudformation"
}

# Back off timer - aws-cloudformation
resource "time_sleep" "aws_cloudformation_wait_300_seconds" {
  # After aws-cloudformation mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_cloudformation]
  create_duration = var.backoff_duration
}

# Install mod - aws-cloudfront
resource "turbot_mod" "aws_cloudfront" {
  # Wait for aws-cloudformation timer to run out
  depends_on = [time_sleep.aws_cloudformation_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-cloudfront"
}

# Back off timer - aws-cloudfront
resource "time_sleep" "aws_cloudfront_wait_300_seconds" {
  # After aws-cloudfront mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_cloudfront]
  create_duration = var.backoff_duration
}

# Install mod - aws-cloudsearch
resource "turbot_mod" "aws_cloudsearch" {
  # Wait for aws-cloudfront timer to run out
  depends_on = [time_sleep.aws_cloudfront_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-cloudsearch"
}

# Back off timer - aws-cloudsearch
resource "time_sleep" "aws_cloudsearch_wait_300_seconds" {
  # After aws-cloudsearch mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_cloudsearch]
  create_duration = var.backoff_duration
}

# Install mod - aws-cloudtrail
resource "turbot_mod" "aws_cloudtrail" {
  # Wait for aws-cloudsearch timer to run out
  depends_on = [time_sleep.aws_cloudsearch_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-cloudtrail"
}

# Back off timer - aws-cloudtrail
resource "time_sleep" "aws_cloudtrail_wait_300_seconds" {
  # After aws-cloudtrail mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_cloudtrail]
  create_duration = var.backoff_duration
}

# Install mod - aws-cloudwatch
resource "turbot_mod" "aws_cloudwatch" {
  # Wait for aws-cloudtrail timer to run out
  depends_on = [time_sleep.aws_cloudtrail_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-cloudwatch"
}

# Back off timer - aws-cloudwatch
resource "time_sleep" "aws_cloudwatch_wait_300_seconds" {
  # After aws-cloudwatch mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_cloudwatch]
  create_duration = var.backoff_duration
}

# Install mod - aws-codebuild
resource "turbot_mod" "aws_codebuild" {
  # Wait for aws-cloudwatch timer to run out
  depends_on = [time_sleep.aws_cloudwatch_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-codebuild"
}

# Back off timer - aws-codebuild
resource "time_sleep" "aws_codebuild_wait_300_seconds" {
  # After aws-codebuild mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_codebuild]
  create_duration = var.backoff_duration
}

# Install mod - aws-codecommit
resource "turbot_mod" "aws_codecommit" {
  # Wait for aws-codebuild timer to run out
  depends_on = [time_sleep.aws_codebuild_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-codecommit"
}

# Back off timer - aws-codecommit
resource "time_sleep" "aws_codecommit_wait_300_seconds" {
  # After aws-codecommit mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_codecommit]
  create_duration = var.backoff_duration
}

# Install mod - aws-codedeploy
resource "turbot_mod" "aws_codedeploy" {
  # Wait for aws-codecommit timer to run out
  depends_on = [time_sleep.aws_codecommit_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-codedeploy"
}

# Back off timer - aws-codedeploy
resource "time_sleep" "aws_codedeploy_wait_300_seconds" {
  # After aws-codedeploy mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_codedeploy]
  create_duration = var.backoff_duration
}

# Install mod - aws-codepipeline
resource "turbot_mod" "aws_codepipeline" {
  # Wait for aws-codedeploy timer to run out
  depends_on = [time_sleep.aws_codedeploy_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-codepipeline"
}

# Back off timer - aws-codepipeline
resource "time_sleep" "aws_codepipeline_wait_300_seconds" {
  # After aws-codepipeline mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_codepipeline]
  create_duration = var.backoff_duration
}

# Install mod - aws-cognito
resource "turbot_mod" "aws_cognito" {
  # Wait for aws-codepipeline timer to run out
  depends_on = [time_sleep.aws_codepipeline_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-cognito"
}

# Back off timer - aws-cognito
resource "time_sleep" "aws_cognito_wait_300_seconds" {
  # After aws-cognito mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_cognito]
  create_duration = var.backoff_duration
}

# Install mod - aws-comprehend
resource "turbot_mod" "aws_comprehend" {
  # Wait for aws-cognito timer to run out
  depends_on = [time_sleep.aws_cognito_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-comprehend"
}

# Back off timer - aws-comprehend
resource "time_sleep" "aws_comprehend_wait_300_seconds" {
  # After aws-comprehend mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_comprehend]
  create_duration = var.backoff_duration
}

# Install mod - aws-computeoptimizer
resource "turbot_mod" "aws_computeoptimizer" {
  # Wait for aws-comprehend timer to run out
  depends_on = [time_sleep.aws_comprehend_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-computeoptimizer"
}

# Back off timer - aws-computeoptimizer
resource "time_sleep" "aws_computeoptimizer_wait_300_seconds" {
  # After aws-computeoptimizer mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_computeoptimizer]
  create_duration = var.backoff_duration
}

# Install mod - aws-config
resource "turbot_mod" "aws_config" {
  # Wait for aws-computeoptimizer timer to run out
  depends_on = [time_sleep.aws_computeoptimizer_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-config"
}

# Back off timer - aws-config
resource "time_sleep" "aws_config_wait_300_seconds" {
  # After aws-config mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_config]
  create_duration = var.backoff_duration
}

# Install mod - aws-connect
resource "turbot_mod" "aws_connect" {
  # Wait for aws-config timer to run out
  depends_on = [time_sleep.aws_config_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-connect"
}

# Back off timer - aws-connect
resource "time_sleep" "aws_connect_wait_300_seconds" {
  # After aws-connect mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_connect]
  create_duration = var.backoff_duration
}

# Install mod - aws-datapipeline
resource "turbot_mod" "aws_datapipeline" {
  # Wait for aws-connect timer to run out
  depends_on = [time_sleep.aws_connect_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-datapipeline"
}

# Back off timer - aws-datapipeline
resource "time_sleep" "aws_datapipeline_wait_300_seconds" {
  # After aws-datapipeline mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_datapipeline]
  create_duration = var.backoff_duration
}

# Install mod - aws-datasync
resource "turbot_mod" "aws_datasync" {
  # Wait for aws-datapipeline timer to run out
  depends_on = [time_sleep.aws_datapipeline_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-datasync"
}

# Back off timer - aws-datasync
resource "time_sleep" "aws_datasync_wait_300_seconds" {
  # After aws-datasync mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_datasync]
  create_duration = var.backoff_duration
}

# Install mod - aws-devicefarm
resource "turbot_mod" "aws_devicefarm" {
  # Wait for aws-datasync timer to run out
  depends_on = [time_sleep.aws_datasync_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-devicefarm"
}

# Back off timer - aws-devicefarm
resource "time_sleep" "aws_devicefarm_wait_300_seconds" {
  # After aws-devicefarm mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_devicefarm]
  create_duration = var.backoff_duration
}

# Install mod - aws-directconnect
resource "turbot_mod" "aws_directconnect" {
  # Wait for aws-devicefarm timer to run out
  depends_on = [time_sleep.aws_devicefarm_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-directconnect"
}

# Back off timer - aws-directconnect
resource "time_sleep" "aws_directconnect_wait_300_seconds" {
  # After aws-directconnect mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_directconnect]
  create_duration = var.backoff_duration
}

# Install mod - aws-directoryservice
resource "turbot_mod" "aws_directoryservice" {
  # Wait for aws-directconnect timer to run out
  depends_on = [time_sleep.aws_directconnect_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-directoryservice"
}

# Back off timer - aws-directoryservice
resource "time_sleep" "aws_directoryservice_wait_300_seconds" {
  # After aws-directoryservice mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_directoryservice]
  create_duration = var.backoff_duration
}

# Install mod - aws-dms
resource "turbot_mod" "aws_dms" {
  # Wait for aws-directoryservice timer to run out
  depends_on = [time_sleep.aws_directoryservice_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-dms"
}

# Back off timer - aws-dms
resource "time_sleep" "aws_dms_wait_300_seconds" {
  # After aws-dms mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_dms]
  create_duration = var.backoff_duration
}

# Install mod - aws-dynamodb
resource "turbot_mod" "aws_dynamodb" {
  # Wait for aws-dms timer to run out
  depends_on = [time_sleep.aws_dms_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-dynamodb"
}

# Back off timer - aws-dynamodb
resource "time_sleep" "aws_dynamodb_wait_300_seconds" {
  # After aws-dynamodb mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_dynamodb]
  create_duration = var.backoff_duration
}

# Install mod - aws-ec2
resource "turbot_mod" "aws_ec2" {
  # Wait for aws-dynamodb timer to run out
  depends_on = [time_sleep.aws_dynamodb_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-ec2"
}

# Back off timer - aws-ec2
resource "time_sleep" "aws_ec2_wait_300_seconds" {
  # After aws-ec2 mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_ec2]
  create_duration = var.backoff_duration
}

# Install mod - aws-ecr
resource "turbot_mod" "aws_ecr" {
  # Wait for aws-ec2 timer to run out
  depends_on = [time_sleep.aws_ec2_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-ecr"
}

# Back off timer - aws-ecr
resource "time_sleep" "aws_ecr_wait_300_seconds" {
  # After aws-ecr mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_ecr]
  create_duration = var.backoff_duration
}

# Install mod - aws-ecs
resource "turbot_mod" "aws_ecs" {
  # Wait for aws-ecr timer to run out
  depends_on = [time_sleep.aws_ecr_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-ecs"
}

# Back off timer - aws-ecs
resource "time_sleep" "aws_ecs_wait_300_seconds" {
  # After aws-ecs mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_ecs]
  create_duration = var.backoff_duration
}

# Install mod - aws-efs
resource "turbot_mod" "aws_efs" {
  # Wait for aws-ecs timer to run out
  depends_on = [time_sleep.aws_ecs_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-efs"
}

# Back off timer - aws-efs
resource "time_sleep" "aws_efs_wait_300_seconds" {
  # After aws-efs mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_efs]
  create_duration = var.backoff_duration
}

# Install mod - aws-eks
resource "turbot_mod" "aws_eks" {
  # Wait for aws-efs timer to run out
  depends_on = [time_sleep.aws_efs_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-eks"
}

# Back off timer - aws-eks
resource "time_sleep" "aws_eks_wait_300_seconds" {
  # After aws-eks mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_eks]
  create_duration = var.backoff_duration
}

# Install mod - aws-elasticache
resource "turbot_mod" "aws_elasticache" {
  # Wait for aws-eks timer to run out
  depends_on = [time_sleep.aws_eks_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-elasticache"
}

# Back off timer - aws-elasticache
resource "time_sleep" "aws_elasticache_wait_300_seconds" {
  # After aws-elasticache mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_elasticache]
  create_duration = var.backoff_duration
}

# Install mod - aws-elasticbeanstalk
resource "turbot_mod" "aws_elasticbeanstalk" {
  # Wait for aws-elasticache timer to run out
  depends_on = [time_sleep.aws_elasticache_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-elasticbeanstalk"
}

# Back off timer - aws-elasticbeanstalk
resource "time_sleep" "aws_elasticbeanstalk_wait_300_seconds" {
  # After aws-elasticbeanstalk mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_elasticbeanstalk]
  create_duration = var.backoff_duration
}

# Install mod - aws-elasticsearch
resource "turbot_mod" "aws_elasticsearch" {
  # Wait for aws-elasticbeanstalk timer to run out
  depends_on = [time_sleep.aws_elasticbeanstalk_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-elasticsearch"
}

# Back off timer - aws-elasticsearch
resource "time_sleep" "aws_elasticsearch_wait_300_seconds" {
  # After aws-elasticsearch mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_elasticsearch]
  create_duration = var.backoff_duration
}

# Install mod - aws-elastictranscoder
resource "turbot_mod" "aws_elastictranscoder" {
  # Wait for aws-elasticsearch timer to run out
  depends_on = [time_sleep.aws_elasticsearch_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-elastictranscoder"
}

# Back off timer - aws-elastictranscoder
resource "time_sleep" "aws_elastictranscoder_wait_300_seconds" {
  # After aws-elastictranscoder mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_elastictranscoder]
  create_duration = var.backoff_duration
}

# Install mod - aws-emr
resource "turbot_mod" "aws_emr" {
  # Wait for aws-elastictranscoder timer to run out
  depends_on = [time_sleep.aws_elastictranscoder_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-emr"
}

# Back off timer - aws-emr
resource "time_sleep" "aws_emr_wait_300_seconds" {
  # After aws-emr mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_emr]
  create_duration = var.backoff_duration
}

# Install mod - aws-events
resource "turbot_mod" "aws_events" {
  # Wait for aws-emr timer to run out
  depends_on = [time_sleep.aws_emr_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-events"
}

# Back off timer - aws-events
resource "time_sleep" "aws_events_wait_300_seconds" {
  # After aws-events mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_events]
  create_duration = var.backoff_duration
}

# Install mod - aws-fsx
resource "turbot_mod" "aws_fsx" {
  # Wait for aws-events timer to run out
  depends_on = [time_sleep.aws_events_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-fsx"
}

# Back off timer - aws-fsx
resource "time_sleep" "aws_fsx_wait_300_seconds" {
  # After aws-fsx mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_fsx]
  create_duration = var.backoff_duration
}

# Install mod - aws-glacier
resource "turbot_mod" "aws_glacier" {
  # Wait for aws-fsx timer to run out
  depends_on = [time_sleep.aws_fsx_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-glacier"
}

# Back off timer - aws-glacier
resource "time_sleep" "aws_glacier_wait_300_seconds" {
  # After aws-glacier mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_glacier]
  create_duration = var.backoff_duration
}

# Install mod - aws-glue
resource "turbot_mod" "aws_glue" {
  # Wait for aws-glacier timer to run out
  depends_on = [time_sleep.aws_glacier_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-glue"
}

# Back off timer - aws-glue
resource "time_sleep" "aws_glue_wait_300_seconds" {
  # After aws-glue mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_glue]
  create_duration = var.backoff_duration
}

# Install mod - aws-guardduty
resource "turbot_mod" "aws_guardduty" {
  # Wait for aws-glue timer to run out
  depends_on = [time_sleep.aws_glue_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-guardduty"
}

# Back off timer - aws-guardduty
resource "time_sleep" "aws_guardduty_wait_300_seconds" {
  # After aws-guardduty mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_guardduty]
  create_duration = var.backoff_duration
}

# Install mod - aws-iot
resource "turbot_mod" "aws_iot" {
  # Wait for aws-guardduty timer to run out
  depends_on = [time_sleep.aws_guardduty_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-iot"
}

# Back off timer - aws-iot
resource "time_sleep" "aws_iot_wait_300_seconds" {
  # After aws-iot mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_iot]
  create_duration = var.backoff_duration
}

# Install mod - aws-kinesis
resource "turbot_mod" "aws_kinesis" {
  # Wait for aws-iot timer to run out
  depends_on = [time_sleep.aws_iot_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-kinesis"
}

# Back off timer - aws-kinesis
resource "time_sleep" "aws_kinesis_wait_300_seconds" {
  # After aws-kinesis mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_kinesis]
  create_duration = var.backoff_duration
}

# Install mod - aws-kms
resource "turbot_mod" "aws_kms" {
  # Wait for aws-kinesis timer to run out
  depends_on = [time_sleep.aws_kinesis_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-kms"
}

# Back off timer - aws-kms
resource "time_sleep" "aws_kms_wait_300_seconds" {
  # After aws-kms mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_kms]
  create_duration = var.backoff_duration
}

# Install mod - aws-lambda
resource "turbot_mod" "aws_lambda" {
  # Wait for aws-kms timer to run out
  depends_on = [time_sleep.aws_kms_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-lambda"
}

# Back off timer - aws-lambda
resource "time_sleep" "aws_lambda_wait_300_seconds" {
  # After aws-lambda mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_lambda]
  create_duration = var.backoff_duration
}

# Install mod - aws-lex
resource "turbot_mod" "aws_lex" {
  # Wait for aws-lambda timer to run out
  depends_on = [time_sleep.aws_lambda_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-lex"
}

# Back off timer - aws-lex
resource "time_sleep" "aws_lex_wait_300_seconds" {
  # After aws-lex mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_lex]
  create_duration = var.backoff_duration
}

# Install mod - aws-logs
resource "turbot_mod" "aws_logs" {
  # Wait for aws-lex timer to run out
  depends_on = [time_sleep.aws_lex_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-logs"
}

# Back off timer - aws-logs
resource "time_sleep" "aws_logs_wait_300_seconds" {
  # After aws-logs mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_logs]
  create_duration = var.backoff_duration
}

# Install mod - aws-machinelearning
resource "turbot_mod" "aws_machinelearning" {
  # Wait for aws-logs timer to run out
  depends_on = [time_sleep.aws_logs_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-machinelearning"
}

# Back off timer - aws-machinelearning
resource "time_sleep" "aws_machinelearning_wait_300_seconds" {
  # After aws-machinelearning mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_machinelearning]
  create_duration = var.backoff_duration
}

# Install mod - aws-macie
resource "turbot_mod" "aws_macie" {
  # Wait for aws-machinelearning timer to run out
  depends_on = [time_sleep.aws_machinelearning_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-macie"
}

# Back off timer - aws-macie
resource "time_sleep" "aws_macie_wait_300_seconds" {
  # After aws-macie mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_macie]
  create_duration = var.backoff_duration
}

# Install mod - aws-mediaconvert
resource "turbot_mod" "aws_mediaconvert" {
  # Wait for aws-macie timer to run out
  depends_on = [time_sleep.aws_macie_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-mediaconvert"
}

# Back off timer - aws-mediaconvert
resource "time_sleep" "aws_mediaconvert_wait_300_seconds" {
  # After aws-mediaconvert mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_mediaconvert]
  create_duration = var.backoff_duration
}

# Install mod - aws-mq
resource "turbot_mod" "aws_mq" {
  # Wait for aws-mediaconvert timer to run out
  depends_on = [time_sleep.aws_mediaconvert_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-mq"
}

# Back off timer - aws-mq
resource "time_sleep" "aws_mq_wait_300_seconds" {
  # After aws-mq mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_mq]
  create_duration = var.backoff_duration
}

# Install mod - aws-polly
resource "turbot_mod" "aws_polly" {
  # Wait for aws-mq timer to run out
  depends_on = [time_sleep.aws_mq_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-polly"
}

# Back off timer - aws-polly
resource "time_sleep" "aws_polly_wait_300_seconds" {
  # After aws-polly mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_polly]
  create_duration = var.backoff_duration
}

# Install mod - aws-quicksight
resource "turbot_mod" "aws_quicksight" {
  # Wait for aws-polly timer to run out
  depends_on = [time_sleep.aws_polly_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-quicksight"
}

# Back off timer - aws-quicksight
resource "time_sleep" "aws_quicksight_wait_300_seconds" {
  # After aws-quicksight mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_quicksight]
  create_duration = var.backoff_duration
}

# Install mod - aws-rds
resource "turbot_mod" "aws_rds" {
  # Wait for aws-quicksight timer to run out
  depends_on = [time_sleep.aws_quicksight_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-rds"
}

# Back off timer - aws-rds
resource "time_sleep" "aws_rds_wait_300_seconds" {
  # After aws-rds mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_rds]
  create_duration = var.backoff_duration
}

# Install mod - aws-redshift
resource "turbot_mod" "aws_redshift" {
  # Wait for aws-rds timer to run out
  depends_on = [time_sleep.aws_rds_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-redshift"
}

# Back off timer - aws-redshift
resource "time_sleep" "aws_redshift_wait_300_seconds" {
  # After aws-redshift mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_redshift]
  create_duration = var.backoff_duration
}

# Install mod - aws-rekognition
resource "turbot_mod" "aws_rekognition" {
  # Wait for aws-redshift timer to run out
  depends_on = [time_sleep.aws_redshift_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-rekognition"
}

# Back off timer - aws-rekognition
resource "time_sleep" "aws_rekognition_wait_300_seconds" {
  # After aws-rekognition mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_rekognition]
  create_duration = var.backoff_duration
}

# Install mod - aws-resourcegroups
resource "turbot_mod" "aws_resourcegroups" {
  # Wait for aws-rekognition timer to run out
  depends_on = [time_sleep.aws_rekognition_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-resourcegroups"
}

# Back off timer - aws-resourcegroups
resource "time_sleep" "aws_resourcegroups_wait_300_seconds" {
  # After aws-resourcegroups mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_resourcegroups]
  create_duration = var.backoff_duration
}

# Install mod - aws-route53
resource "turbot_mod" "aws_route53" {
  # Wait for aws-resourcegroups timer to run out
  depends_on = [time_sleep.aws_resourcegroups_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-route53"
}

# Back off timer - aws-route53
resource "time_sleep" "aws_route53_wait_300_seconds" {
  # After aws-route53 mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_route53]
  create_duration = var.backoff_duration
}

# Install mod - aws-s3
resource "turbot_mod" "aws_s3" {
  # Wait for aws-route53 timer to run out
  depends_on = [time_sleep.aws_route53_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-s3"
}

# Back off timer - aws-s3
resource "time_sleep" "aws_s3_wait_300_seconds" {
  # After aws-s3 mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_s3]
  create_duration = var.backoff_duration
}

# Install mod - aws-sagemaker
resource "turbot_mod" "aws_sagemaker" {
  # Wait for aws-s3 timer to run out
  depends_on = [time_sleep.aws_s3_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-sagemaker"
}

# Back off timer - aws-sagemaker
resource "time_sleep" "aws_sagemaker_wait_300_seconds" {
  # After aws-sagemaker mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_sagemaker]
  create_duration = var.backoff_duration
}

# Install mod - aws-secretsmanager
resource "turbot_mod" "aws_secretsmanager" {
  # Wait for aws-sagemaker timer to run out
  depends_on = [time_sleep.aws_sagemaker_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-secretsmanager"
}

# Back off timer - aws-secretsmanager
resource "time_sleep" "aws_secretsmanager_wait_300_seconds" {
  # After aws-secretsmanager mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_secretsmanager]
  create_duration = var.backoff_duration
}

# Install mod - aws-securityhub
resource "turbot_mod" "aws_securityhub" {
  # Wait for aws-secretsmanager timer to run out
  depends_on = [time_sleep.aws_secretsmanager_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-securityhub"
}

# Back off timer - aws-securityhub
resource "time_sleep" "aws_securityhub_wait_300_seconds" {
  # After aws-securityhub mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_securityhub]
  create_duration = var.backoff_duration
}

# Install mod - aws-servermigration
resource "turbot_mod" "aws_servermigration" {
  # Wait for aws-securityhub timer to run out
  depends_on = [time_sleep.aws_securityhub_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-servermigration"
}

# Back off timer - aws-servermigration
resource "time_sleep" "aws_servermigration_wait_300_seconds" {
  # After aws-servermigration mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_servermigration]
  create_duration = var.backoff_duration
}

# Install mod - aws-servicecatalog
resource "turbot_mod" "aws_servicecatalog" {
  # Wait for aws-servermigration timer to run out
  depends_on = [time_sleep.aws_servermigration_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-servicecatalog"
}

# Back off timer - aws-servicecatalog
resource "time_sleep" "aws_servicecatalog_wait_300_seconds" {
  # After aws-servicecatalog mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_servicecatalog]
  create_duration = var.backoff_duration
}

# Install mod - aws-ses
resource "turbot_mod" "aws_ses" {
  # Wait for aws-servicecatalog timer to run out
  depends_on = [time_sleep.aws_servicecatalog_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-ses"
}

# Back off timer - aws-ses
resource "time_sleep" "aws_ses_wait_300_seconds" {
  # After aws-ses mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_ses]
  create_duration = var.backoff_duration
}

# Install mod - aws-shield
resource "turbot_mod" "aws_shield" {
  # Wait for aws-ses timer to run out
  depends_on = [time_sleep.aws_ses_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-shield"
}

# Back off timer - aws-shield
resource "time_sleep" "aws_shield_wait_300_seconds" {
  # After aws-shield mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_shield]
  create_duration = var.backoff_duration
}

# Install mod - aws-simpledb
resource "turbot_mod" "aws_simpledb" {
  # Wait for aws-shield timer to run out
  depends_on = [time_sleep.aws_shield_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-simpledb"
}

# Back off timer - aws-simpledb
resource "time_sleep" "aws_simpledb_wait_300_seconds" {
  # After aws-simpledb mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_simpledb]
  create_duration = var.backoff_duration
}

# Install mod - aws-snowball
resource "turbot_mod" "aws_snowball" {
  # Wait for aws-simpledb timer to run out
  depends_on = [time_sleep.aws_simpledb_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-snowball"
}

# Back off timer - aws-snowball
resource "time_sleep" "aws_snowball_wait_300_seconds" {
  # After aws-snowball mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_snowball]
  create_duration = var.backoff_duration
}

# Install mod - aws-sns
resource "turbot_mod" "aws_sns" {
  # Wait for aws-snowball timer to run out
  depends_on = [time_sleep.aws_snowball_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-sns"
}

# Back off timer - aws-sns
resource "time_sleep" "aws_sns_wait_300_seconds" {
  # After aws-sns mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_sns]
  create_duration = var.backoff_duration
}

# Install mod - aws-sqs
resource "turbot_mod" "aws_sqs" {
  # Wait for aws-sns timer to run out
  depends_on = [time_sleep.aws_sns_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-sqs"
}

# Back off timer - aws-sqs
resource "time_sleep" "aws_sqs_wait_300_seconds" {
  # After aws-sqs mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_sqs]
  create_duration = var.backoff_duration
}

# Install mod - aws-ssm
resource "turbot_mod" "aws_ssm" {
  # Wait for aws-sqs timer to run out
  depends_on = [time_sleep.aws_sqs_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-ssm"
}

# Back off timer - aws-ssm
resource "time_sleep" "aws_ssm_wait_300_seconds" {
  # After aws-ssm mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_ssm]
  create_duration = var.backoff_duration
}

# Install mod - aws-stepfunctions
resource "turbot_mod" "aws_stepfunctions" {
  # Wait for aws-ssm timer to run out
  depends_on = [time_sleep.aws_ssm_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-stepfunctions"
}

# Back off timer - aws-stepfunctions
resource "time_sleep" "aws_stepfunctions_wait_300_seconds" {
  # After aws-stepfunctions mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_stepfunctions]
  create_duration = var.backoff_duration
}

# Install mod - aws-storagegateway
resource "turbot_mod" "aws_storagegateway" {
  # Wait for aws-stepfunctions timer to run out
  depends_on = [time_sleep.aws_stepfunctions_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-storagegateway"
}

# Back off timer - aws-storagegateway
resource "time_sleep" "aws_storagegateway_wait_300_seconds" {
  # After aws-storagegateway mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_storagegateway]
  create_duration = var.backoff_duration
}

# Install mod - aws-tagging
resource "turbot_mod" "aws_tagging" {
  # Wait for aws-storagegateway timer to run out
  depends_on = [time_sleep.aws_storagegateway_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-tagging"
}

# Back off timer - aws-tagging
resource "time_sleep" "aws_tagging_wait_300_seconds" {
  # After aws-tagging mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_tagging]
  create_duration = var.backoff_duration
}

# Install mod - aws-textract
resource "turbot_mod" "aws_textract" {
  # Wait for aws-tagging timer to run out
  depends_on = [time_sleep.aws_tagging_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-textract"
}

# Back off timer - aws-textract
resource "time_sleep" "aws_textract_wait_300_seconds" {
  # After aws-textract mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_textract]
  create_duration = var.backoff_duration
}

# Install mod - aws-transcribe
resource "turbot_mod" "aws_transcribe" {
  # Wait for aws-textract timer to run out
  depends_on = [time_sleep.aws_textract_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-transcribe"
}

# Back off timer - aws-transcribe
resource "time_sleep" "aws_transcribe_wait_300_seconds" {
  # After aws-transcribe mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_transcribe]
  create_duration = var.backoff_duration
}

# Install mod - aws-transfer
resource "turbot_mod" "aws_transfer" {
  # Wait for aws-transcribe timer to run out
  depends_on = [time_sleep.aws_transcribe_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-transfer"
}

# Back off timer - aws-transfer
resource "time_sleep" "aws_transfer_wait_300_seconds" {
  # After aws-transfer mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_transfer]
  create_duration = var.backoff_duration
}

# Install mod - aws-translate
resource "turbot_mod" "aws_translate" {
  # Wait for aws-transfer timer to run out
  depends_on = [time_sleep.aws_transfer_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-translate"
}

# Back off timer - aws-translate
resource "time_sleep" "aws_translate_wait_300_seconds" {
  # After aws-translate mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_translate]
  create_duration = var.backoff_duration
}

# Install mod - aws-trustedadvisor
resource "turbot_mod" "aws_trustedadvisor" {
  # Wait for aws-translate timer to run out
  depends_on = [time_sleep.aws_translate_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-trustedadvisor"
}

# Back off timer - aws-trustedadvisor
resource "time_sleep" "aws_trustedadvisor_wait_300_seconds" {
  # After aws-trustedadvisor mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_trustedadvisor]
  create_duration = var.backoff_duration
}

# Install mod - aws-vpc-connect
resource "turbot_mod" "aws_vpc_connect" {
  # Wait for aws-trustedadvisor timer to run out
  depends_on = [time_sleep.aws_trustedadvisor_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-vpc-connect"
}

# Back off timer - aws-vpc-connect
resource "time_sleep" "aws_vpc_connect_wait_300_seconds" {
  # After aws-vpc-connect mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_vpc_connect]
  create_duration = var.backoff_duration
}

# Install mod - aws-vpc-core
resource "turbot_mod" "aws_vpc_core" {
  # Wait for aws-vpc-connect timer to run out
  depends_on = [time_sleep.aws_vpc_connect_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-vpc-core"
}

# Back off timer - aws-vpc-core
resource "time_sleep" "aws_vpc_core_wait_300_seconds" {
  # After aws-vpc-core mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_vpc_core]
  create_duration = var.backoff_duration
}

# Install mod - aws-vpc-internet
resource "turbot_mod" "aws_vpc_internet" {
  # Wait for aws-vpc-core timer to run out
  depends_on = [time_sleep.aws_vpc_core_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-vpc-internet"
}

# Back off timer - aws-vpc-internet
resource "time_sleep" "aws_vpc_internet_wait_300_seconds" {
  # After aws-vpc-internet mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_vpc_internet]
  create_duration = var.backoff_duration
}

# Install mod - aws-vpc-security
resource "turbot_mod" "aws_vpc_security" {
  # Wait for aws-vpc-internet timer to run out
  depends_on = [time_sleep.aws_vpc_internet_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-vpc-security"
}

# Back off timer - aws-vpc-security
resource "time_sleep" "aws_vpc_security_wait_300_seconds" {
  # After aws-vpc-security mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_vpc_security]
  create_duration = var.backoff_duration
}

# Install mod - aws-waf
resource "turbot_mod" "aws_waf" {
  # Wait for aws-vpc-security timer to run out
  depends_on = [time_sleep.aws_vpc_security_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-waf"
}

# Back off timer - aws-waf
resource "time_sleep" "aws_waf_wait_300_seconds" {
  # After aws-waf mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_waf]
  create_duration = var.backoff_duration
}

# Install mod - aws-workdocs
resource "turbot_mod" "aws_workdocs" {
  # Wait for aws-waf timer to run out
  depends_on = [time_sleep.aws_waf_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-workdocs"
}

# Back off timer - aws-workdocs
resource "time_sleep" "aws_workdocs_wait_300_seconds" {
  # After aws-workdocs mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_workdocs]
  create_duration = var.backoff_duration
}

# Install mod - aws-workspaces
resource "turbot_mod" "aws_workspaces" {
  # Wait for aws-workdocs timer to run out
  depends_on = [time_sleep.aws_workdocs_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-workspaces"
}

# Back off timer - aws-workspaces
resource "time_sleep" "aws_workspaces_wait_300_seconds" {
  # After aws-workspaces mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_workspaces]
  create_duration = var.backoff_duration
}

# Install mod - aws-xray
resource "turbot_mod" "aws_xray" {
  # Wait for aws-workspaces timer to run out
  depends_on = [time_sleep.aws_workspaces_wait_300_seconds]
  org        = "turbot"
  parent     = "tmod:@turbot/turbot#/"
  version    = ">=5.0.0"
  mod        = "aws-xray"
}

# Back off timer - aws-xray
resource "time_sleep" "aws_xray_wait_300_seconds" {
  # After aws-xray mod is installed, wait 300 seconds
  depends_on      = [turbot_mod.aws_xray]
  create_duration = var.backoff_duration
}
