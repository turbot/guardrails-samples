# Baseline Configuration

variable "resource_approved_regions" {
  description = <<DESC
  Map of the list of approved regions controls.

  Possible values for the key of this map is found in locals.tf defined in the local variable policy_map.
  For example `aws-acm-certificate : "tmod:@turbot/aws-acm#/policy/types/certificateApproved"` has key `aws-acm-certificate`.

  The value of the map is one of these possible values:
    - "Skip"
    - "Check: Approved"
    - "Enforce: Delete unapproved if new"

  Check demo.tfvars for an example of how to set this value.

  NOTE: Default behaviour is to approve all services which means expecting all mods to be installed
  DESC
  type        = map(string)
  default = {
    aws-acm-certificate                        = "Check: Approved"
    aws-mq-broker                              = "Check: Approved"
    aws-mq-configuration                       = "Check: Approved"
    aws-amplify-app                            = "Check: Approved"
    aws-apigateway-api                         = "Check: Approved"
    aws-apigateway-apiKey                      = "Check: Approved"
    aws-apigateway-apiV2                       = "Check: Approved"
    aws-apigateway-authorizer                  = "Check: Approved"
    aws-apigateway-authorizerV2                = "Check: Approved"
    aws-apigateway-domainNameV2                = "Check: Approved"
    aws-apigateway-stage                       = "Check: Approved"
    aws-apigateway-stageV2                     = "Check: Approved"
    aws-apigateway-usagePlan                   = "Check: Approved"
    aws-appmesh-mesh                           = "Check: Approved"
    aws-athena-namedQuery                      = "Check: Approved"
    aws-athena-workgroup                       = "Check: Approved"
    aws-backup-backupPlan                      = "Check: Approved"
    aws-backup-backupVault                     = "Check: Approved"
    aws-batch-jobDefinition                    = "Check: Approved"
    aws-cloudformation-stack                   = "Check: Approved"
    aws-cloudformation-stackSet                = "Check: Approved"
    aws-cloudsearch-domain                     = "Check: Approved"
    aws-cloudtrail-trail                       = "Check: Approved"
    aws-cloudwatch-alarm                       = "Check: Approved"
    aws-codebuild-build                        = "Check: Approved"
    aws-codebuild-project                      = "Check: Approved"
    aws-codecommit-repository                  = "Check: Approved"
    aws-config-configurationRecorder           = "Check: Approved"
    aws-config-deliveryChannel                 = "Check: Approved"
    aws-config-rule                            = "Check: Approved"
    aws-dax-cluster                            = "Check: Approved"
    aws-directoryservice-directory             = "Check: Approved"
    aws-dms-endpoint                           = "Check: Approved"
    aws-docdb-dbCluster                        = "Check: Approved"
    aws-docdb-dbClusterParameterGroup          = "Check: Approved"
    aws-docdb-dbInstance                       = "Check: Approved"
    aws-dynamodb-backup                        = "Check: Approved"
    aws-dynamodb-table                         = "Check: Approved"
    aws-ec2-ami                                = "Check: Approved"
    aws-ec2-applicationLoadBalancer            = "Check: Approved"
    aws-ec2-autoScalingGroup                   = "Check: Approved"
    aws-ec2-classicLoadBalancer                = "Check: Approved"
    aws-ec2-instance                           = "Check: Approved"
    aws-ec2-keyPair                            = "Check: Approved"
    aws-ec2-launchConfiguration                = "Check: Approved"
    aws-ec2-launchTemplate                     = "Check: Approved"
    aws-ec2-launchTemplateVersion              = "Check: Approved"
    aws-ec2-listenerRule                       = "Check: Approved"
    aws-ec2-loadBalancerListener               = "Check: Approved"
    aws-ec2-networkInterface                   = "Check: Approved"
    aws-ec2-networkLoadBalancer                = "Check: Approved"
    aws-ec2-snapshot                           = "Check: Approved"
    aws-ec2-targetGroup                        = "Check: Approved"
    aws-ec2-volume                             = "Check: Approved"
    aws-ecr-repository                         = "Check: Approved"
    aws-ecs-cluster                            = "Check: Approved"
    aws-ecs-containerInstance                  = "Check: Approved"
    aws-ecs-taskDefinition                     = "Check: Approved"
    aws-efs-fileSystem                         = "Check: Approved"
    aws-efs-mountTarget                        = "Check: Approved"
    aws-eks-cluster                            = "Check: Approved"
    aws-eks-nodeGroup                          = "Check: Approved"
    aws-elasticbeanstalk-application           = "Check: Approved"
    aws-elasticbeanstalk-environment           = "Check: Approved"
    aws-elasticache-cacheCluster               = "Check: Approved"
    aws-elasticache-cacheParameterGroup        = "Check: Approved"
    aws-elasticache-replicationGroup           = "Check: Approved"
    aws-elasticache-snapshot                   = "Check: Approved"
    aws-elasticsearch-domain                   = "Check: Approved"
    aws-emr-cluster                            = "Check: Approved"
    aws-emr-securityConfiguration              = "Check: Approved"
    aws-events-rule                            = "Check: Approved"
    aws-events-target                          = "Check: Approved"
    aws-fsx-backup                             = "Check: Approved"
    aws-fsx-fileSystem                         = "Check: Approved"
    aws-glacier-vault                          = "Check: Approved"
    aws-glue-database                          = "Check: Approved"
    aws-guardduty-detector                     = "Check: Approved"
    aws-guardduty-ipSet                        = "Check: Approved"
    aws-guardduty-threatIntelSet               = "Check: Approved"
    aws-inspector-assessmentTarget             = "Check: Approved"
    aws-inspector-assessmentTemplate           = "Check: Approved"
    aws-kinesis-consumer                       = "Check: Approved"
    aws-kinesis-stream                         = "Check: Approved"
    aws-kms-key                                = "Check: Approved"
    aws-lambda-function                        = "Check: Approved"
    aws-logs-logGroup                          = "Check: Approved"
    aws-logs-logStream                         = "Check: Approved"
    aws-logs-metricFilter                      = "Check: Approved"
    aws-msk-cluster                            = "Check: Approved"
    aws-neptune-dbCluster                      = "Check: Approved"
    aws-neptune-dbInstance                     = "Check: Approved"
    aws-qldb-ledger                            = "Check: Approved"
    aws-rds-dbCluster                          = "Check: Approved"
    aws-rds-dbClusterParameterGroup            = "Check: Approved"
    aws-rds-dbClusterSnapshotManual            = "Check: Approved"
    aws-rds-dbInstance                         = "Check: Approved"
    aws-rds-dbParameterGroup                   = "Check: Approved"
    aws-rds-dbSnapshotManual                   = "Check: Approved"
    aws-rds-optionGroup                        = "Check: Approved"
    aws-rds-subnetGroup                        = "Check: Approved"
    aws-redshift-cluster                       = "Check: Approved"
    aws-redshift-clusterParameterGroup         = "Check: Approved"
    aws-redshift-clusterSubnetGroup            = "Check: Approved"
    aws-redshift-clusterSnapshotManual         = "Check: Approved"
    aws-robomaker-fleet                        = "Check: Approved"
    aws-robomaker-robot                        = "Check: Approved"
    aws-robomaker-robotApplication             = "Check: Approved"
    aws-route53resolver-resolverEndpoint       = "Check: Approved"
    aws-route53resolver-resolverRule           = "Check: Approved"
    aws-s3-bucket                              = "Check: Approved"
    aws-secretsmanager-secret                  = "Check: Approved"
    aws-securityhub-hub                        = "Check: Approved"
    aws-sns-subscription                       = "Check: Approved"
    aws-sns-topic                              = "Check: Approved"
    aws-sqs-queue                              = "Check: Approved"
    aws-ssm-association                        = "Check: Approved"
    aws-ssm-document                           = "Check: Approved"
    aws-ssm-maintenanceWindow                  = "Check: Approved"
    aws-ssm-ssmParameter                       = "Check: Approved"
    aws-stepfunctions-stateMachine             = "Check: Approved"
    aws-swf-domain                             = "Check: Approved"
    aws-vpc-connect-customerGateway            = "Check: Approved"
    aws-vpc-core-dhcpOptions                   = "Check: Approved"
    aws-vpc-internet-egressOnlyInternetGateway = "Check: Approved"
    aws-vpc-internet-elasticIp                 = "Check: Approved"
    aws-vpc-internet-vpcEndpoint               = "Check: Approved"
    aws-vpc-internet-vpcEndpointService        = "Check: Approved"
    aws-vpc-security-flowLog                   = "Check: Approved"
    aws-vpc-internet-internetGateway           = "Check: Approved"
    aws-vpc-internet-natGateway                = "Check: Approved"
    aws-vpc-security-networkAcl                = "Check: Approved"
    aws-vpc-connect-vpcPeeringConnection       = "Check: Approved"
    aws-vpc-core-routeTable                    = "Check: Approved"
    aws-vpc-security-securityGroup             = "Check: Approved"
    aws-vpc-core-subnet                        = "Check: Approved"
    aws-vpc-connect-transitGateway             = "Check: Approved"
    aws-vpc-connect-transitGatewayRouteTable   = "Check: Approved"
    aws-vpc-core-vpc                           = "Check: Approved"
    aws-vpc-connect-vpnConnection              = "Check: Approved"
    aws-vpc-connect-vpnGateway                 = "Check: Approved"
    aws-waf-ipSetV2Regional                    = "Check: Approved"
    aws-waf-regexPatternSetV2Regional          = "Check: Approved"
    aws-waf-ruleGroupV2Regional                = "Check: Approved"
    aws-waf-webAclV2Regional                   = "Check: Approved"
    aws-wafregional-rule                       = "Check: Approved"
    aws-wellarchitected-workload               = "Check: Approved"
  }
}

variable "resource_approved_regions_region_list" {
  description = <<DESC
  The expected format is an array of regions names. You may use the '*' and '?' wildcard characters.
  Example of values:
    - us-east-1
    - ap-northeast-1
    - ca-central-1

  NOTE: Default behaviour is to approve all regions
  DESC
  type        = list(string)
  default = [
    "us-east-1",
    "us-east-2",
    "us-west-1",
    "us-west-2",
    "ap-northeast-1",
    "ap-northeast-2",
    "ap-south-1",
    "ap-southeast-1",
    "ap-southeast-2",
    "ca-central-1",
    "eu-central-1",
    "eu-north-1",
    "eu-west-1",
    "eu-west-2",
    "eu-west-3",
    "sa-east-1",
  ]
}

# Optional Common Baseline Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
  default     = "default"
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "AWS Check Regions Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the AWS check regions baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
