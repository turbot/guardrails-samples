variable "resource_active" {
  description = <<DESC
  Map of the list of approved regions controls.

  Possible values for the key of this map is found in locals.tf defined in the local variable policy_map.
  For example `aws-ec2 : "tmod:@turbot/aws-ec2#/policy/types/instanceActive"

  The value of the map is one of these possible values:
      "Skip"
      "Check: Active"
      "Enforce: Delete inactive with 1 day warning"
      "Enforce: Delete inactive with 3 days warning"
      "Enforce: Delete inactive with 7 days warning"
      "Enforce: Delete inactive with 14 days warning"
      "Enforce: Delete inactive with 30 days warning"
      "Enforce: Delete inactive with 60 days warning"
      "Enforce: Delete inactive with 90 days warning"
      "Enforce: Delete inactive with 180 days warning"
      "Enforce: Delete inactive with 365 days warning"

  Check demo.tfvars for an example of how to set this value.

  NOTE: Default behaviour is to approve all services which means expecting all mods to be installed
  DESC
  type        = map(string)
  default = { 
    # aws-acm-certificate                           = "Check: Active"
    # aws-mq-broker                                 = "Check: Active"
    # aws-mq-configuration                          = "Check: Active"
    # aws-amplify-app                               = "Check: Active"
    # aws-apigateway-api                            = "Check: Active"
    # aws-apigateway-apiKey                         = "Check: Active"
    # aws-apigateway-apiV2                          = "Check: Active"
    # aws-apigateway-authorizer                     = "Check: Active"
    # aws-apigateway-authorizerV2                   = "Check: Active"
    # aws-apigateway-domainNameV2                   = "Check: Active"
    # aws-apigateway-stage                          = "Check: Active"
    # aws-apigateway-stageV2                        = "Check: Active"
    # aws-apigateway-usagePlan                      = "Check: Active"
    # aws-appmesh-mesh                              = "Check: Active"
    # aws-athena-namedQuery                         = "Check: Active"
    # aws-athena-workgroup                          = "Check: Active"
    # aws-backup-backupPlan                         = "Check: Active"
    # aws-backup-backupVault                        = "Check: Active"
    # aws-batch-jobDefinition                       = "Check: Active"
    # aws-cloudformation-stack                      = "Check: Active"
    # aws-cloudformation-stackSet                   = "Check: Active"
    # aws-cloudfront-cloudFrontOriginAccessIdentity = "Check: Active"
    # aws-cloudfront-distribution                   = "Check: Active"
    # aws-cloudfront-streamingDistribution          = "Check: Active"
    # aws-cloudsearch-domain                        = "Check: Active"
    # aws-cloudtrail-trail                          = "Check: Active"
    # aws-cloudwatch-alarm                          = "Check: Active"
    # aws-codebuild-build                           = "Check: Active"
    # aws-codebuild-project                         = "Check: Active"
    # aws-codecommit-repository                     = "Check: Active"
    # aws-config-configurationRecorder              = "Check: Active"
    # aws-config-deliveryChannel                    = "Check: Active"
    # aws-config-rule                               = "Check: Active"
    # aws-dax-cluster                               = "Check: Active"
    # aws-directoryservice-directory                = "Check: Active"
    # aws-dms-endpoint                              = "Check: Active"
    # aws-docdb-dbCluster                           = "Check: Active"
    # aws-docdb-dbClusterParameterGroup             = "Check: Active"
    # aws-docdb-dbInstance                          = "Check: Active"
    # aws-dynamodb-backup                           = "Check: Active"
    # aws-dynamodb-globalTable                      = "Check: Active"
    # aws-dynamodb-table                            = "Check: Active"
    aws-ec2-ami                                   = "Check: Active"
    # aws-ec2-applicationLoadBalancer               = "Check: Active"
    # aws-ec2-autoScalingGroup                      = "Check: Active"
    # aws-ec2-classicLoadBalancer                   = "Check: Active"
    aws-ec2-instance                              = "Check: Active"
    # aws-ec2-keyPair                               = "Check: Active"
    # aws-ec2-launchConfiguration                   = "Check: Active"
    # aws-ec2-launchTemplate                        = "Check: Active"
    # aws-ec2-launchTemplateVersion                 = "Check: Active"
    # aws-ec2-listenerRule                          = "Check: Active"
    # aws-ec2-loadBalancerListener                  = "Check: Active"
    # aws-ec2-networkInterface                      = "Check: Active"
    # aws-ec2-networkLoadBalancer                   = "Check: Active"
    aws-ec2-snapshot                              = "Check: Active"
    # aws-ec2-targetGroup                           = "Check: Active"
    ##Have Unattached Policy Set instead## aws-ec2-volume                                = "Check: Active"
    # aws-ecr-repository                            = "Check: Active"
    # aws-ecs-cluster                               = "Check: Active"
    # aws-ecs-containerInstance                     = "Check: Active"
    # aws-ecs-taskDefinition                        = "Check: Active"
    # aws-efs-fileSystem                            = "Check: Active"
    # aws-efs-mountTarget                           = "Check: Active"
    # aws-eks-cluster                               = "Check: Active"
    # aws-eks-nodeGroup                             = "Check: Active"
    # aws-elasticbeanstalk-application              = "Check: Active"
    # aws-elasticbeanstalk-environment              = "Check: Active"
    # aws-elasticache-cacheCluster                  = "Check: Active"
    # aws-elasticache-cacheParameterGroup           = "Check: Active"
    # aws-elasticache-replicationGroup              = "Check: Active"
    # aws-elasticache-snapshot                      = "Check: Active"
    # aws-elasticsearch-domain                      = "Check: Active"
    # aws-emr-cluster                               = "Check: Active"
    # aws-emr-securityConfiguration                 = "Check: Active"
    # aws-events-rule                               = "Check: Active"
    # aws-events-target                             = "Check: Active"
    # aws-fsx-backup                                = "Check: Active"
    # aws-fsx-fileSystem                            = "Check: Active"
    # aws-glacier-vault                             = "Check: Active"
    # aws-glue-database                             = "Check: Active"
    # aws-guardduty-detector                        = "Check: Active"
    # aws-guardduty-ipSet                           = "Check: Active"
    # aws-guardduty-threatIntelSet                  = "Check: Active"
    # aws-iam-accessKey                             = "Check: Active"
    # aws-iam-group                                 = "Check: Active"
    # aws-iam-iamPolicy                             = "Check: Active"
    # aws-iam-role                                  = "Check: Active"
    # aws-iam-user                                  = "Check: Active"
    # aws-inspector-assessmentTarget                = "Check: Active"
    # aws-inspector-assessmentTemplate              = "Check: Active"
    # aws-kinesis-consumer                          = "Check: Active"
    # aws-kinesis-stream                            = "Check: Active"
    # aws-kms-key                                   = "Check: Active"
    aws-lambda-function                           = "Check: Active"
    # aws-logs-logGroup                             = "Check: Active"
    # aws-logs-logStream                            = "Check: Active"
    # aws-logs-metricFilter                         = "Check: Active"
    # aws-msk-cluster                               = "Check: Active"
    # aws-neptune-dbCluster                         = "Check: Active"
    # aws-neptune-dbInstance                        = "Check: Active"
    # aws-qldb-ledger                               = "Check: Active"
    # aws-rds-dbCluster                             = "Check: Active"
    # aws-rds-dbClusterParameterGroup               = "Check: Active"
    # aws-rds-dbClusterSnapshotManual               = "Check: Active"
    # aws-rds-dbInstance                            = "Check: Active"
    # aws-rds-dbParameterGroup                      = "Check: Active"
    # aws-rds-dbSnapshotManual                      = "Check: Active"
    # aws-rds-optionGroup                           = "Check: Active"
    # aws-rds-subnetGroup                           = "Check: Active"
    # aws-redshift-cluster                          = "Check: Active"
    # aws-redshift-clusterParameterGroup            = "Check: Active"
    # aws-redshift-clusterSubnetGroup               = "Check: Active"
    # aws-redshift-clusterSnapshotManual            = "Check: Active"
    # aws-robomaker-fleet                           = "Check: Active"
    # aws-robomaker-robot                           = "Check: Active"
    # aws-robomaker-robotApplication                = "Check: Active"
    # aws-route53-hostedZone                        = "Check: Active"
    # aws-route53resolver-resolverEndpoint          = "Check: Active"
    # aws-route53resolver-resolverRule              = "Check: Active"
    aws-s3-bucket                                 = "Check: Active"
    # aws-secretsmanager-secret                     = "Check: Active"
    # aws-shield-protection                         = "Check: Active"
    # aws-sns-subscription                          = "Check: Active"
    # aws-sns-topic                                 = "Check: Active"
    # aws-sqs-queue                                 = "Check: Active"
    # aws-ssm-association                           = "Check: Active"
    # aws-ssm-document                              = "Check: Active"
    # aws-ssm-maintenanceWindow                     = "Check: Active"
    # aws-ssm-ssmParameter                          = "Check: Active"
    # aws-stepfunctions-stateMachine                = "Check: Active"
    # aws-swf-domain                                = "Check: Active"
    # aws-vpc-connect-customerGateway               = "Check: Active"
    # aws-vpc-core-dhcpOptions                      = "Check: Active"
    # aws-vpc-internet-egressOnlyInternetGateway    = "Check: Active"
    # aws-vpc-internet-elasticIp                    = "Check: Active"
    # aws-vpc-internet-vpcEndpoint                  = "Check: Active"
    # aws-vpc-internet-vpcEndpointService           = "Check: Active"
    # aws-vpc-security-flowLog                      = "Check: Active"
    # aws-vpc-internet-internetGateway              = "Check: Active"
    # aws-vpc-internet-natGateway                   = "Check: Active"
    # aws-vpc-security-networkAcl                   = "Check: Active"
    # aws-vpc-connect-vpcPeeringConnection          = "Check: Active"
    # aws-vpc-core-routeTable                       = "Check: Active"
    # aws-vpc-security-securityGroup                = "Check: Active"
    # aws-vpc-core-subnet                           = "Check: Active"
    # aws-vpc-connect-transitGateway                = "Check: Active"
    # aws-vpc-connect-transitGatewayRouteTable      = "Check: Active"
    # aws-vpc-core-vpc                              = "Check: Active"
    # aws-vpc-connect-vpnConnection                 = "Check: Active"
    # aws-vpc-connect-vpnGateway                    = "Check: Active"
    # aws-waf-ipSet                                 = "Check: Active"
    # aws-waf-ipSetV2Global                         = "Check: Active"
    # aws-waf-ipSetV2Regional                       = "Check: Active"
    # aws-waf-rateBasedRule                         = "Check: Active"
    # aws-waf-regexPatternSetV2Global               = "Check: Active"
    # aws-waf-regexPatternSetV2Regional             = "Check: Active"
    # aws-waf-rule                                  = "Check: Active"
    # aws-waf-ruleGroupV2Global                     = "Check: Active"
    # aws-waf-ruleGroupV2Regional                   = "Check: Active"
    # aws-waf-webacl                                = "Check: Active"
    # aws-waf-webAclV2Global                        = "Check: Active"
    # aws-waf-webAclV2Regional                      = "Check: Active"
    # aws-wafregional-rule                          = "Check: Active"
    # aws-wellarchitected-workload                  = "Check: Active"
  }
}

variable "enable_rds_db_cluster_schedule_policies" {
  type        = bool
  description = "Enabling will ensure encryption  RDS DB Cluster start/stop scheduling, by default this is disabled"
  default     = false
}

variable "enable_rds_cluster_schedule_tag_policies" {
  type        = bool
  description = "Enabling will ensure encryption  RDS DB Cluster start/stop tag policies, by default this is disabled"
  default     = false
}

variable "enable_rds_db_instance_schedule_policies" {
  type        = bool
  description = "Enabling will ensure encryption  RDS DB Instance schedule policies, by default this is disabled"
  default     = false
}

variable "enable_rds_db_instance_schedule_tag_policies" {
  type        = bool
  description = "Enabling will ensure encryption  RDS DB Instance schedule tag policies, by default this is disabled"
  default     = false
}

variable "enable_redshift_cluster_schedule_policies" {
  type        = bool
  description = "Enabling will ensure encryption  Redshift Cluster schedule policies, by default this is disabled"
  default     = false
}

variable "enable_redshift_cluster_schedule_tag_policies" {
  type        = bool
  description = "Enabling will ensure encryption  Redshift Cluster schedule tag policies, by default this is disabled"
  default     = false
}

variable "enable_workspace_schedule_policies" {
  type        = bool
  description = "Enabling will ensure encryption  Workspace schedule policies, by default this is disabled"
  default     = false
}

variable "enable_workspace_schedule_tag_policies" {
  type        = bool
  description = "Enabling will ensure encryption  Workspace schedule tag policies, by default this is disabled"
  default     = false
}

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "AWS Check Cost Control Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the AWS cost control baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}