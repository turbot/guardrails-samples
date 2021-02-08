# List of services to set as Enabled  
# Note: there is no aws-neptune enabled policy
# Note: smaller subset to start with, enable more overtime
# See file, aws_service_enable.tf
enabled_policy_map = {
  # aws-acm                             = "acmEnabled"
  # aws-amplify                         = "amplifyEnabled"
  # aws-apigateway                      = "apiGatewayEnabled"
  # aws-appflow                         = "appFlowEnabled"
  # aws-appmesh                         = "appMeshEnabled"
  # aws-appstream                       = "appStreamEnabled"
  # aws-appsync                         = "appSyncEnabled"
  # aws-artifact                        = "artifactEnabled"
  # aws-athena                          = "athenaEnabled"
  # aws-backup                          = "backupEnabled"
  # aws-batch                           = "batchEnabled"
  # aws-chime                           = "chimeEnabled"
  # aws-cloud9                          = "cloud9Enabled"
  # aws-cloudformation                  = "cloudFormationEnabled"
  # aws-cloudfront                      = "cloudFrontEnabled"
  # aws-cloudhsm                        = "cloudHsmEnabled"
  # aws-cloudsearch                     = "cloudSearchEnabled"
  aws-cloudtrail                      = "cloudTrailEnabled"
  aws-cloudwatch                      = "cloudWatchEnabled"
  # aws-codebuild                       = "codeBuildEnabled"
  # aws-codecommit                      = "codeCommitEnabled"
  # aws-codedeploy                      = "codeDeployEnabled"
  # aws-codepipeline                    = "codePipelineEnabled"
  # aws-codestar                        = "codeStarEnabled"
  # aws-comprehend                      = "comprehendEnabled"
  aws-config                          = "configEnabled"
  # aws-datapipeline                    = "dataPipelineEnabled"
  # aws-dax                             = "daxEnabled"
  # aws-directoryservice                = "directoryServiceEnabled"
  # aws-dms                             = "dmsEnabled"
  # aws-docdb                           = "docDbEnabled"
  # aws-dynamodb                        = "dynamodbEnabled"
  aws-ec2                             = "ec2Enabled"
  # aws-ecr                             = "ecrEnabled"
  # aws-ecs                             = "ecsEnabled"
  # aws-efs                             = "efsEnabled"
  # aws-eks                             = "eksEnabled"
  # aws-elasticache                     = "elastiCacheEnabled"
  # aws-elasticbeanstalk                = "elasticBeanstalkEnabled"
  # aws-elasticsearch                   = "esEnabled"
  # aws-elastictranscoder               = "elasticTranscoderEnabled"
  # aws-emr                             = "emrEnabled"
  aws-events                          = "eventsEnabled"
  # aws-fsx                             = "fsxEnabled"
  # aws-gamelift                        = "gameLiftEnabled"
  # aws-glacier                         = "glacierEnabled"
  # aws-glue                            = "glueEnabled"
  # aws-greengrass                      = "greengrassEnabled"
  # aws-guardduty                       = "guardDutyEnabled"
  # aws-health                          = "healthEnabled"
  aws-iam                             = "iamEnabled"
  # aws-inspector                       = "inspectorEnabled"
  # aws-iot                             = "iotEnabled"
  # aws-iot1click                       = "iot1ClickEnabled"
  # aws-iotanalytics                    = "iotAnalyticsEnabled"
  # aws-iotevents                       = "iotEventsEnabled"
  # aws-iotsitewise                     = "iotSiteWiseEnabled"
  # aws-iotthingsgraph                  = "iotThingsGraphEnabled"
  # aws-kinesis                         = "kinesisEnabled"
  aws-kms                             = "kmsEnabled"
  aws-lambda                          = "lambdaEnabled"
  # aws-lex                             = "lexEnabled"
  # aws-lightsail                       = "lightsailEnabled"
  aws-logs                            = "logsEnabled"
  # aws-machinelearning                 = "machineLearningEnabled"
  # aws-macie                           = "macieEnabled"
  # aws-mediaconnect                    = "mediaConnectEnabled"
  # aws-mediaconvert                    = "mediaConvertEnabled"
  # aws-medialive                       = "mediaLiveEnabled"  
  # aws-mediapackage                    = "mediaPackageEnabled"
  # aws-mediastore                      = "mediaStoreEnabled"
  # aws-mediatailor                     = "mediaTailorEnabled"  
  # aws-mq                              = "mqEnabled"
  # aws-msk                             = "mskEnabled"
  # aws-outposts                        = "outpostsEnabled"
  # aws-qldb                            = "qldbEnabled"
  # aws-ram                             = "ramEnabled"
  # aws-rds                             = "rdsEnabled"
  # aws-redshift                        = "redshiftEnabled"
  # aws-resourcegroups                  = "resourceGroupsEnabled"
  # aws-robomaker                       = "roboMakerEnabled"
  # aws-route53                         = "route53Enabled"
  # aws-route53domains                  = "route53DomainsEnabled"
  # aws-route53resolver                 = "route53ResolverEnabled"
  aws-s3                              = "s3Enabled"
  # aws-sagemaker                       = "sageMakerEnabled"
  # aws-secretsmanager                  = "secretsManagerEnabled"
  # aws-securityhub                     = "securityHubEnabled"
  # aws-serverlessapplicationrepository = "serverlessApplicationRepositoryEnabled"
  # aws-servermigration                 = "serverMigrationServiceEnabled"
  # aws-servicecatalog                  = "serviceCatalogEnabled"
  # aws-shield                          = "shieldEnabled"
  # aws-simpledb                        = "simpleDbEnabled"
  # aws-snowball                        = "snowballEnabled"
  aws-sns                             = "snsEnabled"
  # aws-sqs                             = "sqsEnabled"
  # aws-ssm                             = "ssmEnabled"
  # aws-stepfunctions                   = "stepFunctionsEnabled"
  # aws-storagegateway                  = "storageGatewayEnabled"
  # aws-swf                             = "swfEnabled"
  # aws-textract                        = "textractEnabled"
  # aws-transcribe                      = "transcribeEnabled"
  # aws-transfer                        = "transferEnabled"
  # aws-trustedadvisor                  = "trustedAdvisorEnabled"
  aws-vpc-core                        = "vpcServiceEnabled"
  # aws-waf                             = "wafEnabled"
  # aws-wafregional                     = "wafRegionalEnabled"
  # aws-wellarchitected                 = "wellarchitectedEnabled"
  # aws-workdocs                        = "workDocsEnabled"
  # aws-workspaces                      = "workSpacesEnabled"
  # aws-xray                            = "xrayEnabled"
}

# NOTE: For full list of values, which can be enabled for more than the default region. 
# Look in variables.tf at the default value. 
# This deafult value can be overridden. Uncomment the respective region list to enable Turbot Event Handlers. 
# See this file, regions.tf
aws_account_default_regions = [
  "us-east-1",
  "us-east-2",
  # "us-east-2",
  # "us-west-1",
  # "us-west-2",
  # "ap-northeast-1",
  # "ap-northeast-2",
  # "ap-south-1",
  # "ap-southeast-1",
  # "ap-southeast-2",
  # "ca-central-1",
  # "eu-central-1",
  # "eu-north-1",
  # "eu-west-1",
  # "eu-west-2",
  # "eu-west-3",
  # "sa-east-1",
]