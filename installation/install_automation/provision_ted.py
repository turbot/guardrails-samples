import boto3
import custom

if __name__ == "__main__": 
  config = custom.get_config()
  client = boto3.client('servicecatalog')
  response = client.provision_product(
    ProvisioningArtifactName = config["ted_version"],
    ProvisionedProductName   = 'ted',
    AcceptLanguage           = 'en',
    ProductName              = 'Turbot Enterprise Database',
    PathName                 = 'Turbot',
    Tags                     = config['tags'],
    ProvisioningParameters   = [
      ## Hive Configuration
      {
        'Key'   : "HiveName",
        'Value' : config["hive_name"]
      },
      {
        'Key'   : "PrimaryRegion",
        'Value' : config["alpha_region"]
      },

      ## DB Config
      {
        'Key'   : "InstanceClass",
        'Value' : config["db_type"]
      },
      {
        'Key'   : "ReplicaInstanceClass",
        'Value' : "Same as Primary DB"
      },
      {
        'Key'   : "DatabaseMaintenanceWindow",
        'Value' : ""
      },

      ## DB Replication
      {
        'Key'   : "DatabasePrimaryEndpoint",
        'Value' : ""
      },

      ## DB Advanced - HA
      {
        'Key'   : "FailoverInstance",
        'Value' : config["db_failover"]
      },
      {
        'Key'   : "ReadReplicaInstance",
        'Value' : "false"
      },

      ## Database - Advanced - Engine
      {
        'Key'   : "Engine",
        'Value' : "postgres"
      },
      {
        'Key'   : "EngineFamily",
        'Value' : "postgres13"
      },
      {
        'Key'   : "EngineVersion",
        'Value' : "13.2"
      },
      {
        'Key'   : "ReadReplicaEngineVersion",
        'Value' : "13.2"
      },
      {
        'Key'   : "AllowMajorVersionUpgrade",
        'Value' : "false"
      },

      ## Database - Advanced - Storage
      {
        'Key'   : "StorageType",
        'Value' : "gp2"
      },
      {
        'Key'   : "AllocatedStorage",
        'Value' : "200"
      },
      {
        'Key'   : "MaxAllocatedStorage",
        'Value' : "1000"
      },
      {
        'Key'   : "AllocatedIops",
        'Value' : "1000"
      },

      ## Database - Advanced - Encryption
      {
        'Key'   : "EncryptDatabase",
        'Value' : "aws/rds"
      },
      {
        'Key'   : "RedisEncryptionKey",
        'Value' : "default"
      },
      {
        'Key'   : "KeyAliasSsmValue",
        'Value' : "/{}/enterprise/foundation_key_alias".format(config["install_prefix"])
      },

      ## Database - Advanced - Authentication
      {
        'Key'   : "MasterUsername",
        'Value' : "master"
      },
      {
        'Key'   : "MasterPassword",
        'Value' : ""
      },
      {
        'Key'   : "UseIAMAuth",
        'Value' : "true"
      },

      ## Database - Advanced - Backup & Snapshots
      {
        'Key'   : "DeletionProtection",
        'Value' : "true"
      },
      {
        'Key'   : "BackupRetentionPeriod",
        'Value' : "5"
      },
      {
        'Key'   : "DailyAutomatedBackup",
        'Value' : "0"
      },
      {
        'Key'   : "WeeklyAutomatedBackup",
        'Value' : "0"
      },
      {
        'Key'   : "MonthlyAutomatedBackup",
        'Value' : "0"
      },
      {
        'Key'   : "AutomatedBackupPlanRoleArn",
        'Value' : ""
      },
      {
        'Key'   : "DeleteAutomatedBackups",
        'Value' : "false"
      },
      {
        'Key'   : "BackupVaultNameFormat",
        'Value' : "constant"
      },
      {
        'Key'   : "CopyTagsToSnapshot",
        'Value' : "true"
      },

      ## Database - Advanced - Parameters
      {
        'Key'   : "HiveRDSParamGroup",
        'Value' : "HiveParamGroup13"
      },
      {
        'Key'   : "SharedBuffer",
        'Value' : "{DBInstanceClassMemory/32768}"
      },
      {
        'Key'   : "LogStatement",
        'Value' : "ddl"
      },
      {
        'Key'   : "LogMinDurationStatement",
        'Value' : "2000"
      },
      {
        'Key'   : "LogRetentionPeriod",
        'Value' : "10080"
      },
      {
        'Key'   : "PerformanceInsights",
        'Value' : config["perf_insights"]
      },
      {
        'Key'   : "MaxConnections",
        'Value' : "600"
      },
      {
        'Key'   : "MaxConnectionsAlarmThreshold",
        'Value' : "500"
      },
      {
        'Key'   : "DeadlockTimeout",
        'Value' : "2000"
      },
      {
        'Key'   : "IdleInTransactionSessionTimeout",
        'Value' : "900000"
      },
      {
        'Key'   : "StatementTimeout",
        'Value' : "300000"
      },
      {
        'Key'   : "RdsAdminLoggingLevel",
        'Value' : "disabled"
      },
      {
        'Key'   : "TrackFunction",
        'Value' : "none"
      },
      {
        'Key'   : "WalKeepSize",
        'Value' : "2048"
      },
      
      ## Cache
      {
        'Key'   : "UseElastiCache",
        'Value' : "true"
      },
      {
        'Key'   : "CacheNodeType",
        'Value' : config["cache_type"]
      },
      {
        'Key'   : "CacheNumberOfNodes",
        'Value' : "1"
      },
      {
        'Key'   : "EnableMultiAZ",
        'Value' : "false"
      },

      ## Advanced - Foundation Parameters
      {
        'Key'   : "DatabaseSubnetGroupValue",
        'Value' : "/{}/enterprise/db_subnet_group".format(config["install_prefix"])
      },
      {
        'Key'   : "VpcSecurityGroupsValue",
        'Value' : "/{}/enterprise/db_security_group".format(config["install_prefix"])
      },
      {
        'Key'   : "AuditTrailRetentionDaysValue",
        'Value' : "/{}/enterprise/audit_trail_retention_days".format(config["install_prefix"])
      },
      {
        'Key'   : "FoundationAlphaRegion",
        'Value' : "/{}/enterprise/alpha_region".format(config["install_prefix"])
      },

      ## Advanced - Foundation Overides
      {
        'Key'   : "DatabaseSubnetGroup",
        'Value' : ""
      },
      {
        'Key'   : "VpcSecurityGroups",
        'Value' : ""
      },
      {
        'Key'   : "AuditTrailRetentionDays",
        'Value' : ""
      },

      ## Advanced - Infrastructure
      {
        'Key'   : "ResourceNamePrefix",
        'Value' : config["install_prefix"]
      },
      {
        'Key'   : "ParameterDeploymentTrigger",
        'Value' : "Blue"
      },
      {
        'Key'   : "HiveDevelopmentCommands",
        'Value' : "{}"
      },
      {
        'Key'   : "FoundationDynamicBucketName",
        'Value' : "/{}/enterprise/dynamic_bucket_name".format(config["install_prefix"])
      },
      {
        'Key'   : "FoundationLogBucketNameFormat",
        'Value' : "/{}/enterprise/log_bucket_name_format".format(config["install_prefix"])
      },
      {
        'Key'   : "AuditTrailLogGroupNameFormat",
        'Value' : "constant"
      },
      {
        'Key'   : "ProcessLogInHiveBucketRetentionDays",
        'Value' : "395"
      }
    ]  
  )
