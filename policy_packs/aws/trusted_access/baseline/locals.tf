locals {
  # Static mapping of resource types to their service, resource name, and policy values
  # This is intentionally defined as a local to prevent users from modifying it
  policy_map = {
    ec2-ami = {
      service      = "aws-ec2"
      resourceName = "ami"
      acctPolicy   = "TrustedAccessAccounts"
      skip         = "Skip"
      check        = "Check: Trusted Access > Accounts"
      enforce      = "Enforce: Trusted Access > Accounts"
    }
    ec2-snapshot = {
      service      = "aws-ec2"
      resourceName = "snapshot"
      acctPolicy   = "TrustedAccessAccounts"
      skip         = "Skip"
      check        = "Check: Trusted Access > Accounts"
      enforce      = "Enforce: Trusted Access > Accounts"
    }
    rds-clusterSnapshot = {
      service      = "aws-rds"
      resourceName = "dbClusterSnapshotManual"
      acctPolicy   = "TrustedAccessAccounts"
      skip         = "Skip"
      check        = "Check: Trusted Access > Accounts"
      enforce      = "Enforce: Trusted Access > Accounts"
    }
    rds-dbSnaphot = {
      service      = "aws-rds"
      resourceName = "dbSnapshotManual"
      acctPolicy   = "TrustedAccessAccounts"
      skip         = "Skip"
      check        = "Check: Trusted Access > Accounts"
      enforce      = "Enforce: Trusted Access > Accounts"
    }
    redshift-snapshot = {
      service      = "aws-redshift"
      resourceName = "clusterSnapshotManual"
      acctPolicy   = "TrustedAccessAccounts"
      skip         = "Skip"
      check        = "Check: Trusted Access > Accounts"
      enforce      = "Enforce: Trusted Access > Accounts"
    }
    secretsmanager-secretPolicy = {
      service      = "aws-secretsmanager"
      resourceName = "secretPolicy"
      acctPolicy   = "TrustedAccounts"
      skip         = "Skip"
      check        = "Check: Trusted Access"
      enforce      = "Enforce: Revoke untrusted access"
    }
    glacier-vaultPolicy = {
      service      = "aws-glacier"
      resourceName = "vaultPolicy"
      acctPolicy   = "TrustedAccounts"
      skip         = "Skip"
      check        = "Check: Trusted Access"
      enforce      = "Enforce: Revoke untrusted access"
    }
    iam-rolePolicy = {
      service      = "aws-iam"
      resourceName = "rolePolicy"
      acctPolicy   = "TrustedAccounts"
      skip         = "Skip"
      check        = "Check: Trusted Access"
      enforce      = "Enforce: Revoke untrusted access"
    }
    lambda-functionPolicy = {
      service      = "aws-lambda"
      resourceName = "functionPolicy"
      acctPolicy   = "TrustedAccounts"
      skip         = "Skip"
      check        = "Check: Trusted Access"
      enforce      = "Enforce: Revoke untrusted access"
    }
    lambda-versionPolicy = {
      service      = "aws-lambda"
      resourceName = "functionVersionPolicy"
      acctPolicy   = "TrustedAccounts"
      skip         = "Skip"
      check        = "Check: Trusted Access"
      enforce      = "Enforce: Revoke untrusted access"
    }
    s3-bucketPolicy = {
      service      = "aws-s3"
      resourceName = "bucketPolicy"
      acctPolicy   = "TrustedAccounts"
      skip         = "Skip"
      check        = "Check: Trusted Access"
      enforce      = "Enforce: Revoke untrusted access"
    }
    sns-topicPolicy = {
      service      = "aws-sns"
      resourceName = "topicPolicy"
      acctPolicy   = "TrustedAccounts"
      skip         = "Skip"
      check        = "Check: Trusted Access"
      enforce      = "Enforce: Revoke untrusted access"
    }
    sqs-queuePolicy = {
      service      = "aws-sqs"
      resourceName = "queuePolicy"
      acctPolicy   = "TrustedAccounts"
      skip         = "Skip"
      check        = "Check: Trusted Access"
      enforce      = "Enforce: Revoke untrusted access"
    }
    vpc-endpointPolicy = {
      service      = "aws-vpc-internet"
      resourceName = "vpcEndpointPolicy"
      acctPolicy   = "TrustedAccounts"
      skip         = "Skip"
      check        = "Check: Trusted Access"
      enforce      = "Enforce: Revoke untrusted access"
    }
  }
}