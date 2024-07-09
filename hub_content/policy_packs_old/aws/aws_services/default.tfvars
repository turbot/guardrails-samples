target_resource         = "<resource_id>"

service_status  = {
    aws-cloudtrail      = "Enabled"
    aws-cloudwatch      = "Enabled"
    aws-config          = "Enabled"
    aws-ec2             = "Enabled"
    aws-iam             = "Enabled"
    aws-kms             = "Enabled"
  }

  policy_map  = {
    aws-cloudtrail      = "cloudTrailEnabled"
    aws-cloudwatch      = "cloudWatchEnabled"
    aws-config          = "configEnabled"
    aws-ec2             = "ec2Enabled"
    aws-iam             = "iamEnabled"
    aws-kms             = "kmsEnabled"
  }