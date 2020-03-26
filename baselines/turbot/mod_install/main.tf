resource "turbot_mod" "aws" {
  count = contains(var.mod_list, "aws") ? 1 : 0

  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "aws"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-iam" {
  count = contains(var.mod_list, "aws-iam") ? 1 : 0

  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws]
  org        = "turbot"
  mod        = "aws-iam"
  version    = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-s3" {
  count = contains(var.mod_list, "aws-s3") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam,
    turbot_mod.aws-kms
  ]
  org     = "turbot"
  mod     = "aws-s3"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-kms" {
  count = contains(var.mod_list, "aws-kms") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-kms"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-cloudtrail" {
  count = contains(var.mod_list, "aws-cloudtrail") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-cloudtrail"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-cloudwatch" {
  count = contains(var.mod_list, "aws-cloudwatch") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-cloudwatch"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-config" {
  count = contains(var.mod_list, "aws-config") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-config"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-ec2" {
  count = contains(var.mod_list, "aws-ec2") ? 1 : 0

  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.aws, turbot_mod.aws-iam, turbot_mod.aws-kms]
  org        = "turbot"
  mod        = "aws-ec2"
  version    = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-ecs" {
  count = contains(var.mod_list, "aws-ecs") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-ecs"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-elasticsearch" {
  count = contains(var.mod_list, "aws-elasticsearch") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-elasticsearch"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-logs" {
  count = contains(var.mod_list, "aws-logs") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-logs"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-events" {
  count = contains(var.mod_list, "aws-events") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-events"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-sns" {
  count = contains(var.mod_list, "aws-sns") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-sns"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-vpc-core" {
  count = contains(var.mod_list, "aws-vpc") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam,
    turbot_mod.aws-ec2,
    turbot_mod.aws-kms
  ]
  org     = "turbot"
  mod     = "aws-vpc-core"
  version = ">=5.0.0-beta.1"
}
resource "turbot_mod" "aws-vpc-internet" {
  count = contains(var.mod_list, "aws-vpc") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws-vpc-core
  ]
  org     = "turbot"
  mod     = "aws-vpc-internet"
  version = ">=5.0.0-beta.1"
}
resource "turbot_mod" "aws-vpc-connect" {
  count = contains(var.mod_list, "aws-vpc") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws-vpc-core
  ]
  org     = "turbot"
  mod     = "aws-vpc-connect"
  version = ">=5.0.0-beta.1"
}
resource "turbot_mod" "aws-vpc-security" {
  count = contains(var.mod_list, "aws-vpc") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws-vpc-core
  ]
  org     = "turbot"
  mod     = "aws-vpc-security"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-acm" {
  count = contains(var.mod_list, "aws-acm") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-acm"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-backup" {
  count = contains(var.mod_list, "aws-backup") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-backup"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-codecommit" {
  count = contains(var.mod_list, "aws-codecommit") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-codecommit"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-dynamodb" {
  count = contains(var.mod_list, "aws-dynamodb") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-dynamodb"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-eks" {
  count = contains(var.mod_list, "aws-eks") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-eks"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-greengrass" {
  count = contains(var.mod_list, "aws-greengrass") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-greengrass"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-guardduty" {
  count = contains(var.mod_list, "aws-guardduty") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-guardduty"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-iot" {
  count = contains(var.mod_list, "aws-iot") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-iot"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-lambda" {
  count = contains(var.mod_list, "aws-lambda") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-lambda"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-mediastore" {
  count = contains(var.mod_list, "aws-mediastore") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-mediastore"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-mediatailor" {
  count = contains(var.mod_list, "aws-mediatailor") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-mediatailor"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-rds" {
  count = contains(var.mod_list, "aws-rds") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-rds"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-redshift" {
  count = contains(var.mod_list, "aws-redshift") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam,
    turbot_mod.aws-ec2
  ]
  org     = "turbot"
  mod     = "aws-redshift"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-sagemaker" {
  count = contains(var.mod_list, "aws-sagemaker") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-sagemaker"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-securityhub" {
  count = contains(var.mod_list, "aws-securityhub") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-securityhub"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-simpledb" {
  count = contains(var.mod_list, "aws-simpledb") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-simpledb"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-snowball" {
  count = contains(var.mod_list, "aws-snowball") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-snowball"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-sqs" {
  count = contains(var.mod_list, "aws-sqs") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-sqs"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-ssm" {
  count = contains(var.mod_list, "aws-ssm") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-ssm"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-transfer" {
  count = contains(var.mod_list, "aws-transfer") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-transfer"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-workspaces" {
  count = contains(var.mod_list, "aws-workspaces") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-workspaces"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-xray" {
  count = contains(var.mod_list, "aws-xray") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-xray"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-cisv1" {
  parent = "tmod:@turbot/turbot#/"
  count  = contains(var.mod_list, "aws-cisv1") ? 1 : 0

  depends_on = [
    turbot_mod.aws,
    turbot_mod.cis,
    turbot_mod.aws-cloudtrail,
    turbot_mod.aws-cloudwatch,
    turbot_mod.aws-config,
    turbot_mod.aws-ec2,
    turbot_mod.aws-iam,
    turbot_mod.aws-kms,
    turbot_mod.aws-logs,
    turbot_mod.aws-sns,
    turbot_mod.aws-vpc-core,
    turbot_mod.aws-vpc-connect,
    turbot_mod.aws-vpc-internet,
    turbot_mod.aws-vpc-security
  ]
  org     = "turbot"
  mod     = "aws-cisv1"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-amplify" {
  count = contains(var.mod_list, "aws-amplify") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-amplify"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-apigateway" {
  count = contains(var.mod_list, "aws-apigateway") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-apigateway"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-athena" {
  count = contains(var.mod_list, "aws-athena") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-athena"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-appstream" {
  count = contains(var.mod_list, "aws-appstream") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-appstream"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-batch" {
  count = contains(var.mod_list, "aws-batch") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-batch"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-cloud9" {
  count = contains(var.mod_list, "aws-cloud9") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-cloud9"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-cloudformation" {
  count = contains(var.mod_list, "aws-cloudformation") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-cloudformation"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-cloudsearch" {
  count = contains(var.mod_list, "aws-cloudsearch") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-cloudsearch"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-codedeploy" {
  count = contains(var.mod_list, "aws-codedeploy") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-codedeploy"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-codepipeline" {
  count = contains(var.mod_list, "aws-codepipeline") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-codepipeline"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-directoryservice" {
  count = contains(var.mod_list, "aws-directoryservice") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-directoryservice"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-docdb" {
  count = contains(var.mod_list, "aws-docdb") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam,
    turbot_mod.aws-rds
  ]
  org     = "turbot"
  mod     = "aws-docdb"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-ecr" {
  count = contains(var.mod_list, "aws-ecr") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-ecr"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-efs" {
  count = contains(var.mod_list, "aws-efs") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-efs"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-elasticache" {
  count = contains(var.mod_list, "aws-elasticache") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-elasticache"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-elasticbeanstalk" {
  count = contains(var.mod_list, "aws-elasticbeanstalk") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-elasticbeanstalk"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-emr" {
  count = contains(var.mod_list, "aws-emr") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-emr"
  version = ">=5.0.0-beta.1"
}
resource "turbot_mod" "aws-fsx" {
  count = contains(var.mod_list, "aws-fsx") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-fsx"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-glacier" {
  count = contains(var.mod_list, "aws-glacier") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-glacier"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-inspector" {
  count = contains(var.mod_list, "aws-inspector") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-inspector"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-kinesis" {
  count = contains(var.mod_list, "aws-kinesis") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-kinesis"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-lex" {
  count = contains(var.mod_list, "aws-lex") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-lex"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-mq" {
  count = contains(var.mod_list, "aws-mq") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-mq"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-msk" {
  count = contains(var.mod_list, "aws-msk") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-msk"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-neptune" {
  count = contains(var.mod_list, "aws-neptune") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam,
    turbot_mod.aws-rds
  ]
  org     = "turbot"
  mod     = "aws-neptune"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-ram" {
  count = contains(var.mod_list, "aws-ram") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-ram"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-route53" {
  count = contains(var.mod_list, "aws-route53") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-route53"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-secretsmanager" {
  count = contains(var.mod_list, "aws-secretsmanager") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-secretsmanager"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-servicecatalog" {
  count = contains(var.mod_list, "aws-servicecatalog") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-servicecatalog"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-shield" {
  count = contains(var.mod_list, "aws-shield") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-shield"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-swf" {
  count = contains(var.mod_list, "aws-swf") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-swf"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "aws-wafregional" {
  count = contains(var.mod_list, "aws-wafregional") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.aws,
    turbot_mod.aws-iam
  ]
  org     = "turbot"
  mod     = "aws-wafregional"
  version = ">=5.0.0-beta.1"
}



# ################################        GCP_Resources        ###################################

resource "turbot_mod" "gcp" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "gcp"
  version = ">=5.0.0-beta.1"
  count   = contains(var.mod_list, "gcp") ? 1 : 0
}

resource "turbot_mod" "gcp-iam" {
  count = contains(var.mod_list, "gcp-iam") ? 1 : 0

  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp]
  org        = "turbot"
  mod        = "gcp-iam"
  version    = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-appengine" {
  count = contains(var.mod_list, "gcp-appengine") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam
  ]
  org     = "turbot"
  mod     = "gcp-appengine"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-bigquery" {
  count = contains(var.mod_list, "gcp-bigquery") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam
  ]
  org     = "turbot"
  mod     = "gcp-bigquery"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-bigtable" {
  count = contains(var.mod_list, "gcp-bigtable") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam
  ]
  org     = "turbot"
  mod     = "gcp-bigtable"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-computeengine" {
  count = contains(var.mod_list, "gcp-computeengine") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam,
    turbot_mod.gcp-storage
  ]
  org     = "turbot"
  mod     = "gcp-computeengine"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-dataproc" {
  count = contains(var.mod_list, "gcp-dataproc") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam
  ]
  org     = "turbot"
  mod     = "gcp-dataproc"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-dns" {
  count = contains(var.mod_list, "gcp-dns") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam
  ]
  org     = "turbot"
  mod     = "gcp-dns"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-functions" {
  count = contains(var.mod_list, "gcp-functions") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam
  ]
  org     = "turbot"
  mod     = "gcp-functions"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-kms" {
  count = contains(var.mod_list, "gcp-kms") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam
  ]
  org     = "turbot"
  mod     = "gcp-kms"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-kubernetesengine" {
  count = contains(var.mod_list, "gcp-kubernetesengine") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam
  ]
  org     = "turbot"
  mod     = "gcp-kubernetesengine"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-logging" {
  count = contains(var.mod_list, "gcp-logging") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam
  ]
  org     = "turbot"
  mod     = "gcp-logging"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-monitoring" {
  count = contains(var.mod_list, "gcp-monitoring") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam
  ]
  org     = "turbot"
  mod     = "gcp-monitoring"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-network" {
  count = contains(var.mod_list, "gcp-network") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam
  ]
  org     = "turbot"
  mod     = "gcp-network"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-pubsub" {
  count = contains(var.mod_list, "gcp-pubsub") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam
  ]
  org     = "turbot"
  mod     = "gcp-pubsub"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-spanner" {
  count = contains(var.mod_list, "gcp-spanner") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam
  ]
  org     = "turbot"
  mod     = "gcp-spanner"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-sql" {
  count = contains(var.mod_list, "gcp-sql") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam
  ]
  org     = "turbot"
  mod     = "gcp-sql"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-storage" {
  count = contains(var.mod_list, "gcp-storage") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam
  ]
  org     = "turbot"
  mod     = "gcp-storage"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "gcp-cisv1" {
  parent = "tmod:@turbot/turbot#/"
  count  = contains(var.mod_list, "gcp-cisv1") ? 1 : 0

  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam,
    turbot_mod.cis,
    turbot_mod.gcp-computeengine,
    turbot_mod.gcp-dns,
    turbot_mod.gcp-kms,
    turbot_mod.gcp-logging,
    turbot_mod.gcp-network,
    turbot_mod.gcp-sql,
    turbot_mod.gcp-storage
  ]
  org     = "turbot"
  mod     = "gcp-cisv1"
  version = ">=5.0.0-beta.1"
}

# ################################        AZURE_Resources        ###################################

resource "turbot_mod" "azure" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "azure"
  version = ">=5.0.0-beta.1"
  count   = contains(var.mod_list, "azure") ? 1 : 0
}

resource "turbot_mod" "azure-provider" {
  count = contains(var.mod_list, "azure-provider") ? 1 : 0

  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.azure]
  org        = "turbot"
  mod        = "azure-provider"
  version    = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-iam" {
  count = contains(var.mod_list, "azure-iam") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-iam"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-aks" {
  count = contains(var.mod_list, "azure-aks") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-aks"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-apimanagement" {
  count = contains(var.mod_list, "azure-apimanagement") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-apimanagement"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-applicationgateway" {
  count = contains(var.mod_list, "azure-applicationgateway") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-applicationgateway"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-applicationinsights" {
  count = contains(var.mod_list, "azure-applicationinsights") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-applicationinsights"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-appservice" {
  count = contains(var.mod_list, "azure-appservice") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-appservice"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-compute" {
  count = contains(var.mod_list, "azure-compute") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-compute"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-cosmosdb" {
  count = contains(var.mod_list, "azure-cosmosdb") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-cosmosdb"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-datafactory" {
  count = contains(var.mod_list, "azure-datafactory") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-datafactory"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-dns" {
  count = contains(var.mod_list, "azure-dns") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-dns"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-firewall" {
  count = contains(var.mod_list, "azure-firewall") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-firewall"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-frontdoorservice" {
  count = contains(var.mod_list, "azure-frontdoorservice") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-frontdoorservice"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-keyvault" {
  count = contains(var.mod_list, "azure-keyvault") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-keyvault"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-loadbalancer" {
  count = contains(var.mod_list, "azure-loadbalancer") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-loadbalancer"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-loganalytics" {
  count = contains(var.mod_list, "azure-loganalytics") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-loganalytics"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-monitor" {
  count = contains(var.mod_list, "azure-monitor") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-monitor"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-mysql" {
  count = contains(var.mod_list, "azure-mysql") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-mysql"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-network" {
  count = contains(var.mod_list, "azure-network") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-network"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-networkwatcher" {
  count = contains(var.mod_list, "azure-networkwatcher") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider,
    turbot_mod.azure-network
  ]
  org     = "turbot"
  mod     = "azure-networkwatcher"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-postgresql" {
  count = contains(var.mod_list, "azure-postgresql") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-postgresql"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-searchmanagement" {
  count = contains(var.mod_list, "azure-searchmanagement") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-searchmanagement"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-securitycenter" {
  count = contains(var.mod_list, "azure-securitycenter") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-securitycenter"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-sql" {
  count = contains(var.mod_list, "azure-sql") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-sql"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-storage" {
  count = contains(var.mod_list, "azure-storage") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider
  ]
  org     = "turbot"
  mod     = "azure-storage"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "azure-cisv1" {
  count = contains(var.mod_list, "azure-cisv1") ? 1 : 0

  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.azure,
    turbot_mod.azure-iam,
    turbot_mod.azure-provider,
    turbot_mod.azure-aks,
    turbot_mod.azure-appservice,
    turbot_mod.azure-compute,
    turbot_mod.azure-keyvault,
    turbot_mod.azure-monitor,
    turbot_mod.azure-mysql,
    turbot_mod.azure-network,
    turbot_mod.azure-networkwatcher,
    turbot_mod.azure-postgresql,
    turbot_mod.azure-securitycenter,
    turbot_mod.azure-sql,
    turbot_mod.azure-storage
  ]
  org     = "turbot"
  mod     = "azure-cisv1"
  version = ">=5.0.0-beta.1"
}

resource "turbot_mod" "cis" {
  count = contains(var.mod_list, "cis") ? 1 : 0

  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "cis"
  version = ">=5.0.0-beta.1"
}
