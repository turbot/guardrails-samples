variable "resource_tags" {
description = <<DESC

List of services and resources to be checked if its Tags are correct.

These tags must exist for Missing Tag use case if enabled
required_tags = [
  "Owner",
  "Contact",
  "Cost Center",
  "Project ID",
  "Department",
]

The value of the map is one of these possible values:
Acceptable Values:
  "Skip"
  "Check: Tags are correct"
  "Enforce: Set tags"

Check demo.tfvars for an example of how to set this value.
DESC

type          =map(string)
default = {
    # aws-acm-certificate                                  = "Check: Tags are correct"
    # aws-mq-broker                                        = "Check: Tags are correct"
    # aws-mq-configuration                                 = "Check: Tags are correct"
    # aws-amplify-app                                      = "Check: Tags are correct"
    # aws-apigateway-api                                   = "Check: Tags are correct"
    # aws-apigateway-apiKey                                = "Check: Tags are correct"
    # aws-apigateway-apiV2                                 = "Check: Tags are correct"
    # aws-apigateway-domainNameV2                          = "Check: Tags are correct"
    # aws-apigateway-stage                                 = "Check: Tags are correct"
    # aws-apigateway-stageV2                               = "Check: Tags are correct"
    # aws-apigateway-usagePlan                             = "Check: Tags are correct"
    # aws-appmesh-mesh                                     = "Check: Tags are correct"
    # aws-athena-namedQuery                                = "Check: Tags are correct"
    # aws-athena-workgroup                                 = "Check: Tags are correct"
    # aws-backup-backupPlan                                = "Check: Tags are correct"
    # aws-backup-backupVault                               = "Check: Tags are correct"
    # aws-cloudformation-stack                             = "Check: Tags are correct"
    # aws-cloudformation-stackSet                          = "Check: Tags are correct"
    # aws-cloudfront-distribution                          = "Check: Tags are correct"
    # aws-cloudfront-streamingDistribution                 = "Check: Tags are correct"
    # aws-cloudtrail-trail                                 = "Check: Tags are correct"
    # aws-cloudwatch-alarm                                 = "Check: Tags are correct"
    # aws-codebuild-project                                = "Check: Tags are correct"
    # aws-codecommit-repository                            = "Check: Tags are correct"
    # aws-config-rule                                      = "Check: Tags are correct"
    # aws-dax-cluster                                      = "Check: Tags are correct"
    # aws-directoryservice-directory                       = "Check: Tags are correct"
    # aws-dms-endpoint                                     = "Check: Tags are correct"
    # aws-docdb-dbCluster                                  = "Check: Tags are correct"
    # aws-docdb-dbClusterParameterGroup                    = "Check: Tags are correct"
    # aws-docdb-dbInstance                                 = "Check: Tags are correct"
    # aws-dynamodb-table                                   = "Check: Tags are correct"
    # aws-ec2-ami                                          = "Check: Tags are correct"
    # aws-ec2-applicationLoadBalancer                      = "Check: Tags are correct"
    # aws-ec2-autoScalingGroup                             = "Check: Tags are correct"
    # aws-ec2-classicLoadBalancer                          = "Check: Tags are correct"
    aws-ec2-instance                                     = "Check: Tags are correct"
    # aws-ec2-keyPair                                      = "Check: Tags are correct"
    # aws-ec2-launchTemplate                               = "Check: Tags are correct"
    # aws-ec2-networkInterface                             = "Check: Tags are correct"
    # aws-ec2-networkLoadBalancer                          = "Check: Tags are correct"
    aws-ec2-snapshot                                     = "Check: Tags are correct"
    # aws-ec2-targetGroup                                  = "Check: Tags are correct"
    aws-ec2-volume                                       = "Check: Tags are correct"
    # aws-ecr-repository                                   = "Check: Tags are correct"
    # aws-ecs-cluster                                      = "Check: Tags are correct"
    # aws-ecs-taskDefinition                               = "Check: Tags are correct"
    # aws-efs-fileSystem                                   = "Check: Tags are correct"
    # aws-eks-cluster                                      = "Check: Tags are correct"
    # aws-eks-nodeGroup                                    = "Check: Tags are correct"
    # aws-elasticbeanstalk-application                     = "Check: Tags are correct"
    # aws-elasticbeanstalk-environment                     = "Check: Tags are correct"
    # aws-elasticache-cacheCluster                         = "Check: Tags are correct"
    # aws-elasticache-snapshot                             = "Check: Tags are correct"
    # aws-elasticsearch-domain                             = "Check: Tags are correct"
    # aws-emr-cluster                                      = "Check: Tags are correct"
    # aws-fsx-backup                                       = "Check: Tags are correct"
    # aws-fsx-fileSystem                                   = "Check: Tags are correct"
    # aws-glacier-vault                                    = "Check: Tags are correct"
    # aws-guardduty-detector                               = "Check: Tags are correct"
    # aws-guardduty-ipSet                                  = "Check: Tags are correct"
    # aws-guardduty-threatIntelSet                         = "Check: Tags are correct"
    # aws-iam-role                                         = "Check: Tags are correct"
    # aws-iam-user                                         = "Check: Tags are correct"
    # aws-inspector-assessmentTemplate                     = "Check: Tags are correct"
    # aws-kinesis-stream                                   = "Check: Tags are correct"
    # aws-kms-key                                          = "Check: Tags are correct"
    aws-lambda-function                                  = "Check: Tags are correct"
    # aws-logs-logGroup                                    = "Check: Tags are correct"
    # aws-msk-cluster                                      = "Check: Tags are correct"
    # aws-neptune-dbCluster                                = "Check: Tags are correct"
    # aws-neptune-dbInstance                               = "Check: Tags are correct"
    # aws-qldb-ledger                                      = "Check: Tags are correct"
    # aws-rds-dbCluster                                    = "Check: Tags are correct"
    # aws-rds-dbClusterParameterGroup                      = "Check: Tags are correct"
    # aws-rds-dbClusterSnapshotManual                      = "Check: Tags are correct"
    # aws-rds-dbInstance                                   = "Check: Tags are correct"
    # aws-rds-dbParameterGroup                             = "Check: Tags are correct"
    # aws-rds-dbSnapshotManual                             = "Check: Tags are correct"
    # aws-rds-optionGroup                                  = "Check: Tags are correct"
    # aws-rds-subnetGroup                                  = "Check: Tags are correct"
    # aws-redshift-cluster                                 = "Check: Tags are correct"
    # aws-redshift-clusterParameterGroup                   = "Check: Tags are correct"
    # aws-redshift-clusterSubnetGroup                      = "Check: Tags are correct"
    # aws-redshift-clusterSnapshotManual                   = "Check: Tags are correct"
    # aws-robomaker-fleet                                  = "Check: Tags are correct"
    # aws-robomaker-robot                                  = "Check: Tags are correct"
    # aws-robomaker-robotApplication                       = "Check: Tags are correct"
    # aws-route53-hostedZone                               = "Check: Tags are correct"
    # aws-route53resolver-resolverEndpoint                 = "Check: Tags are correct"
    # aws-route53resolver-resolverRule                     = "Check: Tags are correct"
    aws-s3-bucket                                        = "Check: Tags are correct"
    # aws-secretsmanager-secret                            = "Check: Tags are correct"
    # aws-securityhub-hub                                  = "Check: Tags are correct"
    # aws-sns-topic                                        = "Check: Tags are correct"
    # aws-sqs-queue                                        = "Check: Tags are correct"
    # aws-ssm-document                                     = "Check: Tags are correct"
    # aws-ssm-maintenanceWindow                            = "Check: Tags are correct"
    # aws-ssm-ssmParameter                                 = "Check: Tags are correct"
    # aws-stepfunctions-stateMachine                       = "Check: Tags are correct"
    # aws-swf-domain                                       = "Check: Tags are correct"
    # aws-vpc-connect-customerGateway                      = "Check: Tags are correct"
    # aws-vpc-core-dhcpOptions                             = "Check: Tags are correct"
    # aws-vpc-internet-egressOnlyInternetGateway           = "Check: Tags are correct"
    # aws-vpc-internet-elasticIp                           = "Check: Tags are correct"
    # aws-vpc-internet-vpcEndpoint                         = "Check: Tags are correct"
    # aws-vpc-internet-vpcEndpointService                  = "Check: Tags are correct"
    # aws-vpc-security-flowLog                             = "Check: Tags are correct"
    # aws-vpc-internet-internetGateway                     = "Check: Tags are correct"
    # aws-vpc-internet-natGateway                          = "Check: Tags are correct"
    # aws-vpc-security-networkAcl                          = "Check: Tags are correct"
    # aws-vpc-connect-vpcPeeringConnection                 = "Check: Tags are correct"
    # aws-vpc-core-routeTable                              = "Check: Tags are correct"
    aws-vpc-security-securityGroup                       = "Check: Tags are correct"
    # aws-vpc-core-subnet                                  = "Check: Tags are correct"
    # aws-vpc-connect-transitGateway                       = "Check: Tags are correct"
    # aws-vpc-connect-transitGatewayRouteTable             = "Check: Tags are correct"
    aws-vpc-core-vpc                                     = "Check: Tags are correct"
    # aws-vpc-connect-vpnConnection                        = "Check: Tags are correct"
    # aws-vpc-connect-vpnGateway                           = "Check: Tags are correct"
    # aws-waf-ipSetV2Global                                = "Check: Tags are correct"
    # aws-waf-ipSetV2Regional                              = "Check: Tags are correct"
    # aws-waf-regexPatternSetV2Global                      = "Check: Tags are correct"
    # aws-waf-regexPatternSetV2Regional                    = "Check: Tags are correct"
    # aws-waf-ruleGroupV2Global                            = "Check: Tags are correct"
    # aws-waf-ruleGroupV2Regional                          = "Check: Tags are correct"
    # aws-waf-webacl                                       = "Check: Tags are correct"
    # aws-waf-webAclV2Global                               = "Check: Tags are correct"
    # aws-waf-webAclV2Regional                             = "Check: Tags are correct"
  }
}

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "AWS Check Tagging Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the AWS Check Tagging Policies"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}