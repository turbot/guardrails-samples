locals {
  # Map of mods to their respective ServiceNowTable policies
  servicenow_table_policy_map_aws = {
    servicenow-aws = [
      "tmod:@turbot/servicenow-aws#/policy/types/accountServiceNowTable",
      "tmod:@turbot/servicenow-aws#/policy/types/regionServiceNowTable"
    ],
    servicenow-aws-cloudtrail = [
      "tmod:@turbot/servicenow-aws-cloudtrail#/policy/types/trailServiceNowTable",
      "tmod:@turbot/servicenow-aws-cloudwatch#/policy/types/alarmServiceNowTable"
    ],
    servicenow-aws-ec2 = [
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/amiServiceNowTable",
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/instanceServiceNowTable",
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/keyPairServiceNowTable",
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/networkInterfaceServiceNowTable",
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/snapshotServiceNowTable",
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/volumeServiceNowTable"
    ],
    servicenow-aws-iam = [
      "tmod:@turbot/servicenow-aws-iam#/policy/types/groupServiceNowTable",
      "tmod:@turbot/servicenow-aws-iam#/policy/types/roleServiceNowTable",
      "tmod:@turbot/servicenow-aws-iam#/policy/types/userServiceNowTable"
    ],
    servicenow-aws-kms = [
      "tmod:@turbot/servicenow-aws-kms#/policy/types/keyServiceNowTable"
    ],
    servicenow-aws-rds = [
      "tmod:@turbot/servicenow-aws-rds#/policy/types/dbClusterServiceNowTable",
      "tmod:@turbot/servicenow-aws-rds#/policy/types/dbInstanceServiceNowTable"
    ],
    servicenow-aws-s3 = [
      "tmod:@turbot/servicenow-aws-s3#/policy/types/bucketServiceNowTable"
    ],
    servicenow-aws-vpc-connect = [
      "tmod:@turbot/servicenow-aws-vpc-connect#/policy/types/customerGatewayServiceNowTable",
      "tmod:@turbot/servicenow-aws-vpc-connect#/policy/types/transitGatewayServiceNowTable",
      "tmod:@turbot/servicenow-aws-vpc-connect#/policy/types/vpnGatewayServiceNowTable"
    ],
    servicenow-aws-vpc-core = [
      "tmod:@turbot/servicenow-aws-vpc-core#/policy/types/routeTableServiceNowTable",
      "tmod:@turbot/servicenow-aws-vpc-core#/policy/types/subnetServiceNowTable",
      "tmod:@turbot/servicenow-aws-vpc-core#/policy/types/vpcServiceNowTable"
    ],
    servicenow-aws-vpc-internet = [
      "tmod:@turbot/servicenow-aws-vpc-internet#/policy/types/elasticIpServiceNowTable",
      "tmod:@turbot/servicenow-aws-vpc-internet#/policy/types/internetGatewayServiceNowTable",
      "tmod:@turbot/servicenow-aws-vpc-internet#/policy/types/natGatewayServiceNowTable"
    ],
    servicenow-aws-vpc-security = [
      "tmod:@turbot/servicenow-aws-vpc-security#/policy/types/flowLogServiceNowTable",
      "tmod:@turbot/servicenow-aws-vpc-security#/policy/types/networkAclServiceNowTable",
      "tmod:@turbot/servicenow-aws-vpc-security#/policy/types/securityGroupRuleServiceNowTable",
      "tmod:@turbot/servicenow-aws-vpc-security#/policy/types/securityGroupServiceNowTable"
    ]
  }

  # Flatten the Table policies for installed mods
  servicenow_table_policies_aws = flatten([
    for mod in var.servicenow_mod_list_aws : local.servicenow_table_policy_map_aws[mod] if contains(keys(local.servicenow_table_policy_map_aws), mod)
  ])

  # Map of mods to their respective Configuration Items policies
  servicenow_configuration_item_policy_map_aws = {
    servicenow-aws = [
      "tmod:@turbot/servicenow-aws#/policy/types/accountServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws#/policy/types/regionServiceNowConfigurationItem"
    ],
    servicenow-aws-cloudtrail = [
      "tmod:@turbot/servicenow-aws-cloudtrail#/policy/types/trailServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-cloudwatch#/policy/types/alarmServiceNowConfigurationItem"
    ],
    servicenow-aws-ec2 = [
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/amiServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/instanceServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/keyPairServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/networkInterfaceServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/snapshotServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/volumeServiceNowConfigurationItem"
    ],
    servicenow-aws-iam = [
      "tmod:@turbot/servicenow-aws-iam#/policy/types/groupServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-iam#/policy/types/roleServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-iam#/policy/types/userServiceNowConfigurationItem"
    ],
    servicenow-aws-kms = [
      "tmod:@turbot/servicenow-aws-kms#/policy/types/keyServiceNowConfigurationItem"
    ],
    servicenow-aws-rds = [
      "tmod:@turbot/servicenow-aws-rds#/policy/types/dbClusterServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-rds#/policy/types/dbInstanceServiceNowConfigurationItem"
    ],
    servicenow-aws-s3 = [
      "tmod:@turbot/servicenow-aws-s3#/policy/types/bucketServiceNowConfigurationItem"
    ],
    servicenow-aws-vpc-connect = [
      "tmod:@turbot/servicenow-aws-vpc-connect#/policy/types/customerGatewayServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-vpc-connect#/policy/types/transitGatewayServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-vpc-connect#/policy/types/vpnGatewayServiceNowConfigurationItem"
    ],
    servicenow-aws-vpc-core = [
      "tmod:@turbot/servicenow-aws-vpc-core#/policy/types/routeTableServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-vpc-core#/policy/types/subnetServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-vpc-core#/policy/types/vpcServiceNowConfigurationItem"
    ],
    servicenow-aws-vpc-internet = [
      "tmod:@turbot/servicenow-aws-vpc-internet#/policy/types/elasticIpServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-vpc-internet#/policy/types/internetGatewayServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-vpc-internet#/policy/types/natGatewayServiceNowConfigurationItem"
    ],
    servicenow-aws-vpc-security = [
      "tmod:@turbot/servicenow-aws-vpc-security#/policy/types/flowLogServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-vpc-security#/policy/types/networkAclServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-vpc-security#/policy/types/securityGroupRuleServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-aws-vpc-security#/policy/types/securityGroupServiceNowConfigurationItem"
    ]
  }

  # Flatten the Configuration Item policies for installed mods
  servicenow_configuration_item_policies_aws = flatten([
    for mod in var.servicenow_mod_list_aws : local.servicenow_configuration_item_policy_map_aws[mod] if contains(keys(local.servicenow_configuration_item_policy_map_aws), mod)
  ])

  # Map of mods to their respective relationshups policies
  servicenow_relationships_policy_map_aws = {

    servicenow-aws = [
      "tmod:@turbot/servicenow-aws#/policy/types/accountServiceNowRelationships",
      "tmod:@turbot/servicenow-aws#/policy/types/regionServiceNowRelationships"
    ],
    servicenow-aws-cloudtrail = [
    ],
    servicenow-aws-ec2 = [
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/amiServiceNowRelationships",
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/instanceServiceNowRelationships",
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/keyPairServiceNowRelationships",
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/networkInterfaceServiceNowRelationships",
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/snapshotServiceNowRelationships",
      "tmod:@turbot/servicenow-aws-ec2#/policy/types/volumeServiceNowRelationships"
    ],
    servicenow-aws-iam = [
    ],
    servicenow-aws-kms = [
    ],
    servicenow-aws-rds = [
    ],
    servicenow-aws-s3 = [
      "tmod:@turbot/servicenow-aws-s3#/policy/types/bucketServiceNowRelationships"
    ],
    servicenow-aws-vpc-connect = [
      "tmod:@turbot/servicenow-aws-vpc-connect#/policy/types/customerGatewayServiceNowRelationships",
      "tmod:@turbot/servicenow-aws-vpc-connect#/policy/types/transitGatewayServiceNowRelationships",
      "tmod:@turbot/servicenow-aws-vpc-connect#/policy/types/vpnGatewayServiceNowRelationships"
    ],
    servicenow-aws-vpc-core = [
      "tmod:@turbot/servicenow-aws-vpc-core#/policy/types/routeTableServiceNowRelationships",
      "tmod:@turbot/servicenow-aws-vpc-core#/policy/types/subnetServiceNowRelationships",
      "tmod:@turbot/servicenow-aws-vpc-core#/policy/types/vpcServiceNowRelationships"
    ],
    servicenow-aws-vpc-internet = [
      "tmod:@turbot/servicenow-aws-vpc-internet#/policy/types/elasticIpServiceNowRelationships",
      "tmod:@turbot/servicenow-aws-vpc-internet#/policy/types/internetGatewayServiceNowRelationships",
      "tmod:@turbot/servicenow-aws-vpc-internet#/policy/types/natGatewayServiceNowRelationships"
    ],
    servicenow-aws-vpc-security = [
      "tmod:@turbot/servicenow-aws-vpc-security#/policy/types/flowLogServiceNowRelationships",
      "tmod:@turbot/servicenow-aws-vpc-security#/policy/types/networkAclServiceNowRelationships",
      "tmod:@turbot/servicenow-aws-vpc-security#/policy/types/securityGroupRuleServiceNowRelationships",
      "tmod:@turbot/servicenow-aws-vpc-security#/policy/types/securityGroupServiceNowRelationships"
    ]
  }

  # Flatten the Relationships policies for installed mods
  servicenow_relationships_policies_aws = flatten([
    for mod in var.servicenow_mod_list_aws : local.servicenow_relationships_policy_map_aws[mod] if contains(keys(local.servicenow_relationships_policy_map_aws), mod)
  ])

}


