locals {
  # Note: the resource map above dictates the applicable use of each line item below.  You do not need to comment out these items to reduce scope
  policy_map = {
    aws-acm-certificate : "tmod:@turbot/aws-acm#/policy/types/certificateTags"
    aws-mq-broker : "tmod:@turbot/aws-mq#/policy/types/brokerTags"
    aws-mq-configuration : "tmod:@turbot/aws-mq#/policy/types/configurationTags"
    aws-amplify-app : "tmod:@turbot/aws-amplify#/policy/types/appTags"
    aws-apigateway-api : "tmod:@turbot/aws-apigateway#/policy/types/apiTags"
    aws-apigateway-apiKey : "tmod:@turbot/aws-apigateway#/policy/types/apiKeyTags"
    aws-apigateway-apiV2 : "tmod:@turbot/aws-apigateway#/policy/types/apiV2Tags"
    aws-apigateway-domainNameV2 : "tmod:@turbot/aws-apigateway#/policy/types/domainNameV2Tags"
    aws-apigateway-stage : "tmod:@turbot/aws-apigateway#/policy/types/stageTags"
    aws-apigateway-stageV2 : "tmod:@turbot/aws-apigateway#/policy/types/stageV2Tags"
    aws-apigateway-usagePlan : "tmod:@turbot/aws-apigateway#/policy/types/usagePlanTags"
    aws-appmesh-mesh : "tmod:@turbot/aws-appmesh#/policy/types/meshTags"
    aws-athena-namedQuery : "tmod:@turbot/aws-athena#/policy/types/namedQueryTags"
    aws-athena-workgroup : "tmod:@turbot/aws-athena#/policy/types/workgroupTags"
    aws-backup-backupPlan : "tmod:@turbot/aws-backup#/policy/types/backupPlanTags"
    aws-backup-backupVault : "tmod:@turbot/aws-backup#/policy/types/backupVaultTags"
    aws-cloudformation-stack : "tmod:@turbot/aws-cloudformation#/policy/types/stackTags"
    aws-cloudformation-stackSet : "tmod:@turbot/aws-cloudformation#/policy/types/stackSetTags"
    aws-cloudfront-distribution : "tmod:@turbot/aws-cloudfront#/policy/types/distributionTags"
    aws-cloudfront-streamingDistribution : "tmod:@turbot/aws-cloudfront#/policy/types/streamingDistributionTags"
    aws-cloudtrail-trail : "tmod:@turbot/aws-cloudtrail#/policy/types/trailTags"
    aws-cloudwatch-alarm : "tmod:@turbot/aws-cloudwatch#/policy/types/alarmTags"
    aws-codebuild-project : "tmod:@turbot/aws-codebuild#/policy/types/projectTags"
    aws-codecommit-repository : "tmod:@turbot/aws-codecommit#/policy/types/repositoryTags"
    aws-config-rule : "tmod:@turbot/aws-config#/policy/types/ruleTags"
    aws-dax-cluster : "tmod:@turbot/aws-dax#/policy/types/clusterTags"
    aws-directoryservice-directory : "tmod:@turbot/aws-directoryservice#/policy/types/directoryTags"
    aws-dms-endpoint : "tmod:@turbot/aws-dms#/policy/types/endpointTags"
    aws-docdb-dbCluster : "tmod:@turbot/aws-docdb#/policy/types/dbClusterTags"
    aws-docdb-dbClusterParameterGroup : "tmod:@turbot/aws-docdb#/policy/types/dbClusterParameterGroupTags"
    aws-docdb-dbInstance : "tmod:@turbot/aws-docdb#/policy/types/dbInstanceTags"
    aws-dynamodb-table : "tmod:@turbot/aws-dynamodb#/policy/types/tableTags"
    aws-ec2-ami : "tmod:@turbot/aws-ec2#/policy/types/amiTags"
    aws-ec2-applicationLoadBalancer : "tmod:@turbot/aws-ec2#/policy/types/applicationLoadBalancerTags"
    aws-ec2-autoScalingGroup : "tmod:@turbot/aws-ec2#/policy/types/autoScalingGroupTags"
    aws-ec2-classicLoadBalancer : "tmod:@turbot/aws-ec2#/policy/types/classicLoadBalancerTags"
    aws-ec2-instance : "tmod:@turbot/aws-ec2#/policy/types/instanceTags"
    aws-ec2-keyPair : "tmod:@turbot/aws-ec2#/policy/types/keyPairTags"
    aws-ec2-launchTemplate : "tmod:@turbot/aws-ec2#/policy/types/launchTemplateTags"
    aws-ec2-networkInterface : "tmod:@turbot/aws-ec2#/policy/types/networkInterfaceTags"
    aws-ec2-networkLoadBalancer : "tmod:@turbot/aws-ec2#/policy/types/networkLoadBalancerTags"
    aws-ec2-snapshot : "tmod:@turbot/aws-ec2#/policy/types/snapshotTags"
    aws-ec2-targetGroup : "tmod:@turbot/aws-ec2#/policy/types/targetGroupTags"
    aws-ec2-volume : "tmod:@turbot/aws-ec2#/policy/types/volumeTags"
    aws-ecr-repository : "tmod:@turbot/aws-ecr#/policy/types/repositoryTags"
    aws-ecs-cluster : "tmod:@turbot/aws-ecs#/policy/types/clusterTags"
    aws-ecs-taskDefinition : "tmod:@turbot/aws-ecs#/policy/types/taskDefinitionTags"
    aws-efs-fileSystem : "tmod:@turbot/aws-efs#/policy/types/fileSystemTags"
    aws-eks-cluster : "tmod:@turbot/aws-eks#/policy/types/clusterTags"
    aws-eks-nodeGroup : "tmod:@turbot/aws-eks#/policy/types/nodeGroupTags"
    aws-elasticbeanstalk-application : "tmod:@turbot/aws-elasticbeanstalk#/policy/types/applicationTags"
    aws-elasticbeanstalk-environment : "tmod:@turbot/aws-elasticbeanstalk#/policy/types/environmentTags"
    aws-elasticache-cacheCluster : "tmod:@turbot/aws-elasticache#/policy/types/cacheClusterTags"
    aws-elasticache-snapshot : "tmod:@turbot/aws-elasticache#/policy/types/snapshotTags"
    aws-elasticsearch-domain : "tmod:@turbot/aws-elasticsearch#/policy/types/domainTags"
    aws-emr-cluster : "tmod:@turbot/aws-emr#/policy/types/clusterTags"
    aws-fsx-backup : "tmod:@turbot/aws-fsx#/policy/types/backupTags"
    aws-fsx-fileSystem : "tmod:@turbot/aws-fsx#/policy/types/fileSystemTags"
    aws-glacier-vault : "tmod:@turbot/aws-glacier#/policy/types/vaultTags"
    aws-guardduty-detector : "tmod:@turbot/aws-guardduty#/policy/types/detectorTags"
    aws-guardduty-ipSet : "tmod:@turbot/aws-guardduty#/policy/types/ipSetTags"
    aws-guardduty-threatIntelSet : "tmod:@turbot/aws-guardduty#/policy/types/threatIntelSetTags"
    aws-iam-role : "tmod:@turbot/aws-iam#/policy/types/roleTags"
    aws-iam-user : "tmod:@turbot/aws-iam#/policy/types/userTags"
    aws-inspector-assessmentTemplate : "tmod:@turbot/aws-inspector#/policy/types/assessmentTemplateTags"
    aws-kinesis-stream : "tmod:@turbot/aws-kinesis#/policy/types/streamTags"
    aws-kms-key : "tmod:@turbot/aws-kms#/policy/types/keyTags"
    aws-lambda-function : "tmod:@turbot/aws-lambda#/policy/types/functionTags"
    aws-logs-logGroup : "tmod:@turbot/aws-logs#/policy/types/logGroupTags"
    aws-msk-cluster : "tmod:@turbot/aws-msk#/policy/types/clusterTags"
    aws-neptune-dbCluster : "tmod:@turbot/aws-neptune#/policy/types/dbClusterTags"
    aws-neptune-dbInstance : "tmod:@turbot/aws-neptune#/policy/types/dbInstanceTags"
    aws-qldb-ledger : "tmod:@turbot/aws-qldb#/policy/types/ledgerTags"
    aws-rds-dbCluster : "tmod:@turbot/aws-rds#/policy/types/dbClusterTags"
    aws-rds-dbClusterParameterGroup : "tmod:@turbot/aws-rds#/policy/types/dbClusterParameterGroupTags"
    aws-rds-dbClusterSnapshotManual : "tmod:@turbot/aws-rds#/policy/types/dbClusterSnapshotManualTags"
    aws-rds-dbInstance : "tmod:@turbot/aws-rds#/policy/types/dbInstanceTags"
    aws-rds-dbParameterGroup : "tmod:@turbot/aws-rds#/policy/types/dbParameterGroupTags"
    aws-rds-dbSnapshotManual : "tmod:@turbot/aws-rds#/policy/types/dbSnapshotManualTags"
    aws-rds-optionGroup : "tmod:@turbot/aws-rds#/policy/types/optionGroupTags"
    aws-rds-subnetGroup : "tmod:@turbot/aws-rds#/policy/types/subnetGroupTags"
    aws-redshift-cluster : "tmod:@turbot/aws-redshift#/policy/types/clusterTags"
    aws-redshift-clusterParameterGroup : "tmod:@turbot/aws-redshift#/policy/types/clusterParameterGroupTags"
    aws-redshift-clusterSubnetGroup : "tmod:@turbot/aws-redshift#/policy/types/clusterSubnetGroupTags"
    aws-redshift-clusterSnapshotManual : "tmod:@turbot/aws-redshift#/policy/types/clusterSnapshotManualTags"
    aws-robomaker-fleet : "tmod:@turbot/aws-robomaker#/policy/types/fleetTags"
    aws-robomaker-robot : "tmod:@turbot/aws-robomaker#/policy/types/robotTags"
    aws-robomaker-robotApplication : "tmod:@turbot/aws-robomaker#/policy/types/robotApplicationTags"
    aws-route53-hostedZone : "tmod:@turbot/aws-route53#/policy/types/hostedZoneTags"
    aws-route53resolver-resolverEndpoint : "tmod:@turbot/aws-route53resolver#/policy/types/resolverEndpointTags"
    aws-route53resolver-resolverRule : "tmod:@turbot/aws-route53resolver#/policy/types/resolverRuleTags"
    aws-s3-bucket : "tmod:@turbot/aws-s3#/policy/types/bucketTags"
    aws-secretsmanager-secret : "tmod:@turbot/aws-secretsmanager#/policy/types/secretTags"
    aws-securityhub-hub : "tmod:@turbot/aws-securityhub#/policy/types/hubTags"
    aws-sns-topic : "tmod:@turbot/aws-sns#/policy/types/topicTags"
    aws-sqs-queue : "tmod:@turbot/aws-sqs#/policy/types/queueTags"
    aws-ssm-document : "tmod:@turbot/aws-ssm#/policy/types/documentTags"
    aws-ssm-maintenanceWindow : "tmod:@turbot/aws-ssm#/policy/types/maintenanceWindowTags"
    aws-ssm-ssmParameter : "tmod:@turbot/aws-ssm#/policy/types/ssmParameterTags"
    aws-stepfunctions-stateMachine : "tmod:@turbot/aws-stepfunctions#/policy/types/stateMachineTags"
    aws-swf-domain : "tmod:@turbot/aws-swf#/policy/types/domainTags"
    aws-vpc-connect-customerGateway : "tmod:@turbot/aws-vpc-connect#/policy/types/customerGatewayTags"
    aws-vpc-core-dhcpOptions : "tmod:@turbot/aws-vpc-core#/policy/types/dhcpOptionsTags"
    aws-vpc-internet-egressOnlyInternetGateway : "tmod:@turbot/aws-vpc-internet#/policy/types/egressOnlyInternetGatewayTags"
    aws-vpc-internet-elasticIp : "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpTags"
    aws-vpc-internet-vpcEndpoint : "tmod:@turbot/aws-vpc-internet#/policy/types/vpcEndpointTags"
    aws-vpc-internet-vpcEndpointService : "tmod:@turbot/aws-vpc-internet#/policy/types/vpcEndpointServiceTags"
    aws-vpc-security-flowLog : "tmod:@turbot/aws-vpc-security#/policy/types/flowLogTags"
    aws-vpc-internet-internetGateway : "tmod:@turbot/aws-vpc-internet#/policy/types/internetGatewayTags"
    aws-vpc-internet-natGateway : "tmod:@turbot/aws-vpc-internet#/policy/types/natGatewayTags"
    aws-vpc-security-networkAcl : "tmod:@turbot/aws-vpc-security#/policy/types/networkAclTags"
    aws-vpc-connect-vpcPeeringConnection : "tmod:@turbot/aws-vpc-connect#/policy/types/vpcPeeringConnectionTags"
    aws-vpc-core-routeTable : "tmod:@turbot/aws-vpc-core#/policy/types/routeTableTags"
    aws-vpc-security-securityGroup : "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupTags"
    aws-vpc-core-subnet : "tmod:@turbot/aws-vpc-core#/policy/types/subnetTags"
    aws-vpc-connect-transitGateway : "tmod:@turbot/aws-vpc-connect#/policy/types/transitGatewayTags"
    aws-vpc-connect-transitGatewayRouteTable : "tmod:@turbot/aws-vpc-connect#/policy/types/transitGatewayRouteTableTags"
    aws-vpc-core-vpc : "tmod:@turbot/aws-vpc-core#/policy/types/vpcTags"
    aws-vpc-connect-vpnConnection : "tmod:@turbot/aws-vpc-connect#/policy/types/vpnConnectionTags"
    aws-vpc-connect-vpnGateway : "tmod:@turbot/aws-vpc-connect#/policy/types/vpnGatewayTags"
    aws-waf-ipSetV2Global : "tmod:@turbot/aws-waf#/policy/types/ipSetV2GlobalTags"
    aws-waf-ipSetV2Regional : "tmod:@turbot/aws-waf#/policy/types/ipSetV2RegionalTags"
    aws-waf-regexPatternSetV2Global : "tmod:@turbot/aws-waf#/policy/types/regexPatternSetV2GlobalTags"
    aws-waf-regexPatternSetV2Regional : "tmod:@turbot/aws-waf#/policy/types/regexPatternSetV2RegionalTags"
    aws-waf-ruleGroupV2Global : "tmod:@turbot/aws-waf#/policy/types/ruleGroupV2GlobalTags"
    aws-waf-ruleGroupV2Regional : "tmod:@turbot/aws-waf#/policy/types/ruleGroupV2RegionalTags"
    aws-waf-webacl : "tmod:@turbot/aws-waf#/policy/types/webaclTags"
    aws-waf-webAclV2Global : "tmod:@turbot/aws-waf#/policy/types/webAclV2GlobalTags"
    aws-waf-webAclV2Regional : "tmod:@turbot/aws-waf#/policy/types/webAclV2RegionalTags"
  }

  # Mapping of resource name to resource tag map policy
  # Note: the resource map above dictates the applicable use of each line item below.  You do not need to comment out these items to reduce scope
  policy_map_template = {
    aws-acm-certificate : "tmod:@turbot/aws-acm#/policy/types/certificateTagsTemplate"
    aws-mq-broker : "tmod:@turbot/aws-mq#/policy/types/brokerTagsTemplate"
    aws-mq-configuration : "tmod:@turbot/aws-mq#/policy/types/configurationTagsTemplate"
    aws-amplify-app : "tmod:@turbot/aws-amplify#/policy/types/appTagsTemplate"
    aws-apigateway-api : "tmod:@turbot/aws-apigateway#/policy/types/apiTagsTemplate"
    aws-apigateway-apiKey : "tmod:@turbot/aws-apigateway#/policy/types/apiKeyTagsTemplate"
    aws-apigateway-apiV2 : "tmod:@turbot/aws-apigateway#/policy/types/apiV2TagsTemplate"
    aws-apigateway-domainNameV2 : "tmod:@turbot/aws-apigateway#/policy/types/domainNameV2TagsTemplate"
    aws-apigateway-stage : "tmod:@turbot/aws-apigateway#/policy/types/stageTagsTemplate"
    aws-apigateway-stageV2 : "tmod:@turbot/aws-apigateway#/policy/types/stageV2TagsTemplate"
    aws-apigateway-usagePlan : "tmod:@turbot/aws-apigateway#/policy/types/usagePlanTagsTemplate"
    aws-appmesh-mesh : "tmod:@turbot/aws-appmesh#/policy/types/meshTagsTemplate"
    aws-athena-namedQuery : "tmod:@turbot/aws-athena#/policy/types/namedQueryTagsTemplate"
    aws-athena-workgroup : "tmod:@turbot/aws-athena#/policy/types/workgroupTagsTemplate"
    aws-backup-backupPlan : "tmod:@turbot/aws-backup#/policy/types/backupPlanTagsTemplate"
    aws-backup-backupVault : "tmod:@turbot/aws-backup#/policy/types/backupVaultTagsTemplate"
    aws-cloudformation-stack : "tmod:@turbot/aws-cloudformation#/policy/types/stackTagsTemplate"
    aws-cloudformation-stackSet : "tmod:@turbot/aws-cloudformation#/policy/types/stackSetTagsTemplate"
    aws-cloudfront-distribution : "tmod:@turbot/aws-cloudfront#/policy/types/distributionTagsTemplate"
    aws-cloudfront-streamingDistribution : "tmod:@turbot/aws-cloudfront#/policy/types/streamingDistributionTagsTemplate"
    aws-cloudtrail-trail : "tmod:@turbot/aws-cloudtrail#/policy/types/trailTagsTemplate"
    aws-cloudwatch-alarm : "tmod:@turbot/aws-cloudwatch#/policy/types/alarmTagsTemplate"
    aws-codebuild-project : "tmod:@turbot/aws-codebuild#/policy/types/projectTagsTemplate"
    aws-codecommit-repository : "tmod:@turbot/aws-codecommit#/policy/types/repositoryTagsTemplate"
    aws-config-rule : "tmod:@turbot/aws-config#/policy/types/ruleTagsTemplate"
    aws-dax-cluster : "tmod:@turbot/aws-dax#/policy/types/clusterTagsTemplate"
    aws-directoryservice-directory : "tmod:@turbot/aws-directoryservice#/policy/types/directoryTagsTemplate"
    aws-dms-endpoint : "tmod:@turbot/aws-dms#/policy/types/endpointTagsTemplate"
    aws-docdb-dbCluster : "tmod:@turbot/aws-docdb#/policy/types/dbClusterTagsTemplate"
    aws-docdb-dbClusterParameterGroup : "tmod:@turbot/aws-docdb#/policy/types/dbClusterParameterGroupTagsTemplate"
    aws-docdb-dbInstance : "tmod:@turbot/aws-docdb#/policy/types/dbInstanceTagsTemplate"
    aws-dynamodb-table : "tmod:@turbot/aws-dynamodb#/policy/types/tableTagsTemplate"
    aws-ec2-ami : "tmod:@turbot/aws-ec2#/policy/types/amiTagsTemplate"
    aws-ec2-applicationLoadBalancer : "tmod:@turbot/aws-ec2#/policy/types/applicationLoadBalancerTagsTemplate"
    aws-ec2-autoScalingGroup : "tmod:@turbot/aws-ec2#/policy/types/autoScalingGroupTagsTemplate"
    aws-ec2-classicLoadBalancer : "tmod:@turbot/aws-ec2#/policy/types/classicLoadBalancerTagsTemplate"
    aws-ec2-instance : "tmod:@turbot/aws-ec2#/policy/types/instanceTagsTemplate"
    aws-ec2-keyPair : "tmod:@turbot/aws-ec2#/policy/types/keyPairTagsTemplate"
    aws-ec2-launchTemplate : "tmod:@turbot/aws-ec2#/policy/types/launchTemplateTagsTemplate"
    aws-ec2-networkInterface : "tmod:@turbot/aws-ec2#/policy/types/networkInterfaceTagsTemplate"
    aws-ec2-networkLoadBalancer : "tmod:@turbot/aws-ec2#/policy/types/networkLoadBalancerTagsTemplate"
    aws-ec2-snapshot : "tmod:@turbot/aws-ec2#/policy/types/snapshotTagsTemplate"
    aws-ec2-targetGroup : "tmod:@turbot/aws-ec2#/policy/types/targetGroupTagsTemplate"
    aws-ec2-volume : "tmod:@turbot/aws-ec2#/policy/types/volumeTagsTemplate"
    aws-ecr-repository : "tmod:@turbot/aws-ecr#/policy/types/repositoryTagsTemplate"
    aws-ecs-cluster : "tmod:@turbot/aws-ecs#/policy/types/clusterTagsTemplate"
    aws-ecs-taskDefinition : "tmod:@turbot/aws-ecs#/policy/types/taskDefinitionTagsTemplate"
    aws-efs-fileSystem : "tmod:@turbot/aws-efs#/policy/types/fileSystemTagsTemplate"
    aws-eks-cluster : "tmod:@turbot/aws-eks#/policy/types/clusterTagsTemplate"
    aws-eks-nodeGroup : "tmod:@turbot/aws-eks#/policy/types/nodeGroupTagsTemplate"
    aws-elasticbeanstalk-application : "tmod:@turbot/aws-elasticbeanstalk#/policy/types/applicationTagsTemplate"
    aws-elasticbeanstalk-environment : "tmod:@turbot/aws-elasticbeanstalk#/policy/types/environmentTagsTemplate"
    aws-elasticache-cacheCluster : "tmod:@turbot/aws-elasticache#/policy/types/cacheClusterTagsTemplate"
    aws-elasticache-snapshot : "tmod:@turbot/aws-elasticache#/policy/types/snapshotTagsTemplate"
    aws-elasticsearch-domain : "tmod:@turbot/aws-elasticsearch#/policy/types/domainTagsTemplate"
    aws-emr-cluster : "tmod:@turbot/aws-emr#/policy/types/clusterTagsTemplate"
    aws-fsx-backup : "tmod:@turbot/aws-fsx#/policy/types/backupTagsTemplate"
    aws-fsx-fileSystem : "tmod:@turbot/aws-fsx#/policy/types/fileSystemTagsTemplate"
    aws-glacier-vault : "tmod:@turbot/aws-glacier#/policy/types/vaultTagsTemplate"
    aws-guardduty-detector : "tmod:@turbot/aws-guardduty#/policy/types/detectorTagsTemplate"
    aws-guardduty-ipSet : "tmod:@turbot/aws-guardduty#/policy/types/ipSetTagsTemplate"
    aws-guardduty-threatIntelSet : "tmod:@turbot/aws-guardduty#/policy/types/threatIntelSetTagsTemplate"
    aws-iam-role : "tmod:@turbot/aws-iam#/policy/types/roleTagsTemplate"
    aws-iam-user : "tmod:@turbot/aws-iam#/policy/types/userTagsTemplate"
    aws-inspector-assessmentTemplate : "tmod:@turbot/aws-inspector#/policy/types/assessmentTemplateTagsTemplate"
    aws-kinesis-stream : "tmod:@turbot/aws-kinesis#/policy/types/streamTagsTemplate"
    aws-kms-key : "tmod:@turbot/aws-kms#/policy/types/keyTagsTemplate"
    aws-lambda-function : "tmod:@turbot/aws-lambda#/policy/types/functionTagsTemplate"
    aws-logs-logGroup : "tmod:@turbot/aws-logs#/policy/types/logGroupTagsTemplate"
    aws-msk-cluster : "tmod:@turbot/aws-msk#/policy/types/clusterTagsTemplate"
    aws-neptune-dbCluster : "tmod:@turbot/aws-neptune#/policy/types/dbClusterTagsTemplate"
    aws-neptune-dbInstance : "tmod:@turbot/aws-neptune#/policy/types/dbInstanceTagsTemplate"
    aws-qldb-ledger : "tmod:@turbot/aws-qldb#/policy/types/ledgerTagsTemplate"
    aws-rds-dbCluster : "tmod:@turbot/aws-rds#/policy/types/dbClusterTagsTemplate"
    aws-rds-dbClusterParameterGroup : "tmod:@turbot/aws-rds#/policy/types/dbClusterParameterGroupTagsTemplate"
    aws-rds-dbClusterSnapshotManual : "tmod:@turbot/aws-rds#/policy/types/dbClusterSnapshotManualTagsTemplate"
    aws-rds-dbInstance : "tmod:@turbot/aws-rds#/policy/types/dbInstanceTagsTemplate"
    aws-rds-dbParameterGroup : "tmod:@turbot/aws-rds#/policy/types/dbParameterGroupTagsTemplate"
    aws-rds-dbSnapshotManual : "tmod:@turbot/aws-rds#/policy/types/dbSnapshotManualTagsTemplate"
    aws-rds-optionGroup : "tmod:@turbot/aws-rds#/policy/types/optionGroupTagsTemplate"
    aws-rds-subnetGroup : "tmod:@turbot/aws-rds#/policy/types/subnetGroupTagsTemplate"
    aws-redshift-cluster : "tmod:@turbot/aws-redshift#/policy/types/clusterTagsTemplate"
    aws-redshift-clusterParameterGroup : "tmod:@turbot/aws-redshift#/policy/types/clusterParameterGroupTagsTemplate"
    aws-redshift-clusterSubnetGroup : "tmod:@turbot/aws-redshift#/policy/types/clusterSubnetGroupTagsTemplate"
    aws-redshift-clusterSnapshotManual : "tmod:@turbot/aws-redshift#/policy/types/clusterSnapshotManualTagsTemplate"
    aws-robomaker-fleet : "tmod:@turbot/aws-robomaker#/policy/types/fleetTagsTemplate"
    aws-robomaker-robot : "tmod:@turbot/aws-robomaker#/policy/types/robotTagsTemplate"
    aws-robomaker-robotApplication : "tmod:@turbot/aws-robomaker#/policy/types/robotApplicationTagsTemplate"
    aws-route53-hostedZone : "tmod:@turbot/aws-route53#/policy/types/hostedZoneTagsTemplate"
    aws-route53resolver-resolverEndpoint : "tmod:@turbot/aws-route53resolver#/policy/types/resolverEndpointTagsTemplate"
    aws-route53resolver-resolverRule : "tmod:@turbot/aws-route53resolver#/policy/types/resolverRuleTagsTemplate"
    aws-s3-bucket : "tmod:@turbot/aws-s3#/policy/types/bucketTagsTemplate"
    aws-secretsmanager-secret : "tmod:@turbot/aws-secretsmanager#/policy/types/secretTagsTemplate"
    aws-securityhub-hub : "tmod:@turbot/aws-securityhub#/policy/types/hubTagsTemplate"
    aws-sns-topic : "tmod:@turbot/aws-sns#/policy/types/topicTagsTemplate"
    aws-sqs-queue : "tmod:@turbot/aws-sqs#/policy/types/queueTagsTemplate"
    aws-ssm-document : "tmod:@turbot/aws-ssm#/policy/types/documentTagsTemplate"
    aws-ssm-maintenanceWindow : "tmod:@turbot/aws-ssm#/policy/types/maintenanceWindowTagsTemplate"
    aws-ssm-ssmParameter : "tmod:@turbot/aws-ssm#/policy/types/ssmParameterTagsTemplate"
    aws-stepfunctions-stateMachine : "tmod:@turbot/aws-stepfunctions#/policy/types/stateMachineTagsTemplate"
    aws-swf-domain : "tmod:@turbot/aws-swf#/policy/types/domainTagsTemplate"
    aws-vpc-connect-customerGateway : "tmod:@turbot/aws-vpc-connect#/policy/types/customerGatewayTagsTemplate"
    aws-vpc-core-dhcpOptions : "tmod:@turbot/aws-vpc-core#/policy/types/dhcpOptionsTagsTemplate"
    aws-vpc-internet-egressOnlyInternetGateway : "tmod:@turbot/aws-vpc-internet#/policy/types/egressOnlyInternetGatewayTagsTemplate"
    aws-vpc-internet-elasticIp : "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpTagsTemplate"
    aws-vpc-internet-vpcEndpoint : "tmod:@turbot/aws-vpc-internet#/policy/types/vpcEndpointTagsTemplate"
    aws-vpc-internet-vpcEndpointService : "tmod:@turbot/aws-vpc-internet#/policy/types/vpcEndpointServiceTagsTemplate"
    aws-vpc-security-flowLog : "tmod:@turbot/aws-vpc-security#/policy/types/flowLogTagsTemplate"
    aws-vpc-internet-internetGateway : "tmod:@turbot/aws-vpc-internet#/policy/types/internetGatewayTagsTemplate"
    aws-vpc-internet-natGateway : "tmod:@turbot/aws-vpc-internet#/policy/types/natGatewayTagsTemplate"
    aws-vpc-security-networkAcl : "tmod:@turbot/aws-vpc-security#/policy/types/networkAclTagsTemplate"
    aws-vpc-connect-vpcPeeringConnection : "tmod:@turbot/aws-vpc-connect#/policy/types/vpcPeeringConnectionTagsTemplate"
    aws-vpc-core-routeTable : "tmod:@turbot/aws-vpc-core#/policy/types/routeTableTagsTemplate"
    aws-vpc-security-securityGroup : "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupTagsTemplate"
    aws-vpc-core-subnet : "tmod:@turbot/aws-vpc-core#/policy/types/subnetTagsTemplate"
    aws-vpc-connect-transitGateway : "tmod:@turbot/aws-vpc-connect#/policy/types/transitGatewayTagsTemplate"
    aws-vpc-connect-transitGatewayRouteTable : "tmod:@turbot/aws-vpc-connect#/policy/types/transitGatewayRouteTableTagsTemplate"
    aws-vpc-core-vpc : "tmod:@turbot/aws-vpc-core#/policy/types/vpcTagsTemplate"
    aws-vpc-connect-vpnConnection : "tmod:@turbot/aws-vpc-connect#/policy/types/vpnConnectionTagsTemplate"
    aws-vpc-connect-vpnGateway : "tmod:@turbot/aws-vpc-connect#/policy/types/vpnGatewayTagsTemplate"
    aws-waf-ipSetV2Global : "tmod:@turbot/aws-waf#/policy/types/ipSetV2GlobalTagsTemplate"
    aws-waf-ipSetV2Regional : "tmod:@turbot/aws-waf#/policy/types/ipSetV2RegionalTagsTemplate"
    aws-waf-regexPatternSetV2Global : "tmod:@turbot/aws-waf#/policy/types/regexPatternSetV2GlobalTagsTemplate"
    aws-waf-regexPatternSetV2Regional : "tmod:@turbot/aws-waf#/policy/types/regexPatternSetV2RegionalTagsTemplate"
    aws-waf-ruleGroupV2Global : "tmod:@turbot/aws-waf#/policy/types/ruleGroupV2GlobalTagsTemplate"
    aws-waf-ruleGroupV2Regional : "tmod:@turbot/aws-waf#/policy/types/ruleGroupV2RegionalTagsTemplate"
    aws-waf-webacl : "tmod:@turbot/aws-waf#/policy/types/webaclTagsTemplate"
    aws-waf-webAclV2Global : "tmod:@turbot/aws-waf#/policy/types/webAclV2GlobalTagsTemplate"
    aws-waf-webAclV2Regional : "tmod:@turbot/aws-waf#/policy/types/webAclV2RegionalTagsTemplate"
  }
}
