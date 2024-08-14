# List of services to set as Enabled
enabled_policy_map = {
  aws-cloudtrail  = "cloudTrailEnabled"
  aws-cloudwatch  = "cloudWatchEnabled"
  aws-config      = "configEnabled"
  aws-ec2         = "ec2Enabled"
  aws-efs         = "efsEnabled"
  aws-events      = "eventsEnabled"
  aws-iam         = "iamEnabled"
  aws-kms         = "kmsEnabled"
  aws-lambda      = "lambdaEnabled"
  aws-logs        = "logsEnabled"
  aws-rds         = "rdsEnabled"
  aws-s3          = "s3Enabled"
  aws-securityhub = "securityHubEnabled"
  aws-sns         = "snsEnabled"
  aws-vpc-core    = "vpcServiceEnabled"
}
