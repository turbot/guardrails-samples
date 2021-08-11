import boto3
import custom

if __name__ == "__main__": 
  config = custom.get_config()
  client = boto3.client('servicecatalog')
  response = client.provision_product(
    ProvisioningArtifactName = config["tef_version"],
    ProvisionedProductName   = 'tef',
    AcceptLanguage           = 'en',
    ProductName              = 'Turbot Enterprise Foundation',
    PathName                 = 'Turbot',
    Tags                     = config['tags'],
    ProvisioningParameters   = [
      ## Installation
      {
        'Key'   : "InstallationDomain",
        'Value' : config["install_domain"]
      },
      {
        'Key'   : "TurbotCertificateArn",
        'Value' : config["acm_cert_arn"]
      },
      {
        'Key'   : "ManagedRoute53",
        'Value' : "Enabled"
      },
      {
        'Key'   : "RegionCode",
        'Value' : "alpha"
      },
      {
        'Key'   : "LicenseKey",
        'Value' : ""
      },

      ## Logging
      {
        'Key'   : "LogBucketName",
        'Value' : "constant"
      },
      {
        'Key'   : "ProcessLogBucketName",
        'Value' : "constant"
      },
      {
        'Key'   : "LogRetentionDays",
        'Value' : "30"
      },
      {
        'Key'   : "ProcessLogRetentionInDays",
        'Value' : "395"
      },
      {
        'Key'   : "ModInstallDataRetentionDays",
        'Value' : "90"
      },
      {
        'Key'   : "AuditTrailRetentionDays",
        'Value' : "365"
      },

      ## Network Creation [Option A]
      {
        'Key'   : "PublicSubnet1Cidr",
        'Value' : ""
      },
      {
        'Key'   : "PublicSubnet2Cidr",
        'Value' : ""
      },
      {
        'Key'   : "PublicSubnet3Cidr",
        'Value' : ""
      },
      {
        'Key'   : "TurbotSubnet1Cidr",
        'Value' : ""
      },
      {
        'Key'   : "TurbotSubnet2Cidr",
        'Value' : ""
      },
      {
        'Key'   : "TurbotSubnet3Cidr",
        'Value' : ""
      },
      {
        'Key'   : "DatabaseSubnet1Cidr",
        'Value' : ""
      },
      {
        'Key'   : "DatabaseSubnet2Cidr",
        'Value' : ""
      },
      {
        'Key'   : "NatGatewayHighAvailability",
        'Value' : "Multi-AZ"
      },

      ## Predefined Network [Option B]
      {
        'Key'   : "PredefinedVpcId",
        'Value' : config["vpc_id"]
      },
      {
        'Key'   : "PredefinedPublicSubnetIds",
        'Value' : config["web_subnets"]
      },
      {
        'Key'   : "PredefinedTurbotSubnetIds",
        'Value' : config["app_subnets"]
      },
      {
        'Key'   : "PredefinedDatabaseSubnetIds",
        'Value' : config["db_subnets"]
      },

      ## Network Region Configuration
      {
        'Key'   : "VpcAlphaRegion",
        'Value' : config["alpha_region"]
      },
      {
        'Key'   : "VpcAlphaCidr",
        'Value' : config["vpc_cidr"]
      },
      {
        'Key'   : "VpcBetaRegion",
        'Value' : ""
      },
      {
        'Key'   : "VpcBetaCidr",
        'Value' : config["vpc_cidr"]
      },
      {
        'Key'   : "VpcGammaRegion",
        'Value' : ""
      },
      {
        'Key'   : "VpcGammaCidr",
        'Value' : config["vpc_cidr"]
      },
      {
        'Key'   : "VpcBetaId",
        'Value' : ""
      },
      {
        'Key'   : "VpcGammaId",
        'Value' : ""
      },
      {
        'Key'   : "VpcPeeringAlphaToBetaId",
        'Value' : ""
      },
      {
        'Key'   : "VpcPeeringAlphaToGammaId",
        'Value' : ""
      },
      {
        'Key'   : "VpcPeeringAlphaToBetaId",
        'Value' : ""
      },
      {
        'Key'   : "VpcPeeringBetaToGammaId",
        'Value' : ""
      },

      ## Load Balancer
      {
        'Key'   : "LoadBalancerScheme",
        'Value' : config["alb_scheme"]
      },
      {
        'Key'   : "InboundTrafficCidr",
        'Value' : config["client_cidr"]
      },
      {
        'Key'   : "CreateApiGateway",
        'Value' : config["api_gateway"]
      },
      
      ## Proxy
      {
        'Key'   : "HttpProxy",
        'Value' : "null"
      },
      {
        'Key'   : "HttpsProxy",
        'Value' : "null"
      },
      {
        'Key'   : "NoProxy",
        'Value' : "169.254.169.254,169.254.170.2,localhost"
      },

      ## Network - Advanced
      {
        'Key'   : "UseSelfSignedCertificateInALB",
        'Value' : "false"
      },
      {
        'Key'   : "AllowSelfSignedCertificate",
        'Value' : "false"
      },

      ## Network - Security Groups
      {
        'Key'   : "CustomOutboundInternetSecurityGroup",
        'Value' : config["oia_sg_id"]
      },
      {
        'Key'   : "CustomLoadBalancerSecurityGroup",
        'Value' : config["alb_sg_id"]
      },
      {
        'Key'   : "CustomApiServiceSecurityGroup",
        'Value' : config["api_sg_id"]
      },
      {
        'Key'   : "LdapServerCidr",
        'Value' : config["ldap_cidr"]
      },

      ## ECS EC2 Config
      {
        'Key'   : "InstanceType",
        'Value' : "t3.large"
      },
      {
        'Key'   : "ECSAMI",
        'Value' : "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
      },
      {
        'Key'   : "ECSMinInstanceCount",
        'Value' : "1"
      },
      {
        'Key'   : "ECSMaxInstanceCount",
        'Value' : "8"
      },
      {
        'Key'   : "AutoScalingTargetCPU",
        'Value' : "50"
      },

      ## Advanced - Scaling
      
      {
        'Key'   : "ApiDesiredScale",
        'Value' : "2"
      },
      {
        'Key'   : "ApiMinScaling",
        'Value' : "2"
      },
      {
        'Key'   : "ApiMaxScaling",
        'Value' : "4"
      },
      {
        'Key'   : "EventContainerDesiredScale",
        'Value' : "2"
      },
      {
        'Key'   : "EventContainerMinScaling",
        'Value' : "2"
      },
      {
        'Key'   : "EventContainerMaxScaling",
        'Value' : "4"
      },

      ## Advanced - Cache
      {
        'Key'   : "UseElastiCache",
        'Value' : "true"
      },

      ## Advanced - Lambda
      {
        'Key'   : "ModLambdaMaxMemory",
        'Value' : "2048"
      },
      {
        'Key'   : "ModLambdaMaxTimeout",
        'Value' : "300"
      },

      ## Advanced - Worker
      {
        'Key'   : "WorkerLambdaReservedConcurrency",
        'Value' : "50"
      },
      {
        'Key'   : "WorkerLambdaMessageBatch",
        'Value' : "4"
      },
      {
        'Key'   : "WorkerLambdaMemorySize",
        'Value' : "3008"
      },
      {
        'Key'   : "WorkerLambdaTimeout",
        'Value' : "450"
      },
      {
        'Key'   : "WorkerLambdaMaxDBConnections",
        'Value' : "4"
      },

      ## Advanced - Deployment
      {
        'Key'   : "ReleasePhase",
        'Value' : "production"
      },
      {
        'Key'   : "ResourceNamePrefix",
        'Value' : config["install_prefix"]
      },
      {
        'Key'   : "Flags",
        'Value' : config["flags"]
      },
      {
        'Key'   : "OSGuardrails",
        'Value' : config["os_guardrails"]
      },
      {
        'Key'   : "RoleCreationScheme",
        'Value' : "All"
      },
      {
        'Key'   : "TurbotParametersRoleArn",
        'Value' : ""
      },
      {
        'Key'   : "S3BucketArnRoleArn",
        'Value' : ""
      },
      {
        'Key'   : "ParameterDeploymentTrigger",
        'Value' : "Blue"
      },

      ## Advanced - Experimental
      {
        'Key'   : "DevelopmentMode",
        'Value' : "false"
      },
      {
        'Key'   : "ExperimentalFeatures",
        'Value' : "false"
      }
    ]  
  )
