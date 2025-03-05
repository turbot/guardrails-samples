locals {
  # Map of mods to their respective ServiceNowTable policies
  servicenow_table_policy_map_gcp = {
    servicenow-gcp = [
      "tmod:@turbot/servicenow-gcp#/policy/types/globalRegionServiceNowTable",
      "tmod:@turbot/servicenow-gcp#/policy/types/multiRegionServiceNowTable",
      "tmod:@turbot/servicenow-gcp#/policy/types/projectServiceNowTable",
      "tmod:@turbot/servicenow-gcp#/policy/types/regionServiceNowTable",
      "tmod:@turbot/servicenow-gcp#/policy/types/zoneServiceNowTable"
    ],
    servicenow-gcp-appengine = [
      "tmod:@turbot/servicenow-gcp-appengine#/policy/types/applicationServiceNowTable",
      "tmod:@turbot/servicenow-gcp-appengine#/policy/types/firewallRuleServiceNowTable",
      "tmod:@turbot/servicenow-gcp-appengine#/policy/types/instanceServiceNowTable",
      "tmod:@turbot/servicenow-gcp-appengine#/policy/types/serviceServiceNowTable",
      "tmod:@turbot/servicenow-gcp-appengine#/policy/types/versionServiceNowTable"
    ],
    servicenow-gcp-bigquery = [
      "tmod:@turbot/servicenow-gcp-bigquery#/policy/types/datasetServiceNowTable",
      "tmod:@turbot/servicenow-gcp-bigquery#/policy/types/tableServiceNowTable"
    ],
    servicenow-gcp-bigtable = [
      "tmod:@turbot/servicenow-gcp-bigtable#/policy/types/clusterServiceNowTable",
      "tmod:@turbot/servicenow-gcp-bigtable#/policy/types/instanceServiceNowTable",
      "tmod:@turbot/servicenow-gcp-bigtable#/policy/types/tableServiceNowTable"
    ],
    servicenow-gcp-composer = [
      "tmod:@turbot/servicenow-gcp-composer#/policy/types/environmentServiceNowTable"
    ],
    servicenow-gcp-computeengine = [
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/computeProjectServiceNowTable",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/diskServiceNowTable",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/healthCheckServiceNowTable",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/httpHealthCheckServiceNowTable",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/httpsHealthCheckServiceNowTable",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/imageServiceNowTable",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/instanceServiceNowTable",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/instanceTemplateServiceNowTable",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/nodeGroupServiceNowTable",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/nodeTemplateServiceNowTable",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/regionDiskServiceNowTable",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/regionHealthCheckServiceNowTable",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/snapshotServiceNowTable"
    ],
    servicenow-gcp-dataflow = [
      "tmod:@turbot/servicenow-gcp-dataflow#/policy/types/jobServiceNowTable"
    ],
    servicenow-gcp-datapipeline = [
      "tmod:@turbot/servicenow-gcp-datapipeline#/policy/types/pipelineServiceNowTable"
    ],
    servicenow-gcp-dataplex = [
      "tmod:@turbot/servicenow-gcp-dataplex#/policy/types/lakeServiceNowTable",
      "tmod:@turbot/servicenow-gcp-dataplex#/policy/types/taskServiceNowTable",
      "tmod:@turbot/servicenow-gcp-dataplex#/policy/types/zoneServiceNowTable"
    ],
    servicenow-gcp-dataproc = [
      "tmod:@turbot/servicenow-gcp-dataproc#/policy/types/clusterServiceNowTable",
      "tmod:@turbot/servicenow-gcp-dataproc#/policy/types/jobServiceNowTable",
      "tmod:@turbot/servicenow-gcp-dataproc#/policy/types/workflowTemplateServiceNowTable"
    ],
    servicenow-gcp-dns = [
      "tmod:@turbot/servicenow-gcp-dns#/policy/types/managedZoneServiceNowTable"
    ],
    servicenow-gcp-firebase = [
      "tmod:@turbot/servicenow-gcp-firebase#/policy/types/androidAppServiceNowTable",
      "tmod:@turbot/servicenow-gcp-firebase#/policy/types/firebaseProjectServiceNowTable",
      "tmod:@turbot/servicenow-gcp-firebase#/policy/types/iosAppServiceNowTable",
      "tmod:@turbot/servicenow-gcp-firebase#/policy/types/webAppServiceNowTable"
    ],
    servicenow-gcp-functions = [
      "tmod:@turbot/servicenow-gcp-functions#/policy/types/functionServiceNowTable"
    ],
    servicenow-gcp-iam = [
      "tmod:@turbot/servicenow-gcp-iam#/policy/types/projectIamPolicyServiceNowTable",
      "tmod:@turbot/servicenow-gcp-iam#/policy/types/projectRoleServiceNowTable",
      "tmod:@turbot/servicenow-gcp-iam#/policy/types/projectUserServiceNowTable",
      "tmod:@turbot/servicenow-gcp-iam#/policy/types/serviceAccountKeyServiceNowTable",
      "tmod:@turbot/servicenow-gcp-iam#/policy/types/serviceAccountServiceNowTable"
    ],
    servicenow-gcp-kms = [
      "tmod:@turbot/servicenow-gcp-kms#/policy/types/cryptoKeyServiceNowTable",
      "tmod:@turbot/servicenow-gcp-kms#/policy/types/keyRingServiceNowTable"
    ],
    servicenow-gcp-kubernetesengine = [
      "tmod:@turbot/servicenow-gcp-kubernetesengine#/policy/types/regionClusterServiceNowTable",
      "tmod:@turbot/servicenow-gcp-kubernetesengine#/policy/types/regionNodePoolServiceNowTable",
      "tmod:@turbot/servicenow-gcp-kubernetesengine#/policy/types/zoneClusterServiceNowTable",
      "tmod:@turbot/servicenow-gcp-kubernetesengine#/policy/types/zoneNodePoolServiceNowTable"
    ],
    servicenow-gcp-logging = [
      "tmod:@turbot/servicenow-gcp-logging#/policy/types/exclusionServiceNowTable",
      "tmod:@turbot/servicenow-gcp-logging#/policy/types/metricServiceNowTable",
      "tmod:@turbot/servicenow-gcp-logging#/policy/types/sinkServiceNowTable"
    ],
    servicenow-gcp-memorystore = [
      "tmod:@turbot/servicenow-gcp-memorystore#/policy/types/instanceServiceNowTable"
    ],
    servicenow-gcp-monitoring = [
      "tmod:@turbot/servicenow-gcp-monitoring#/policy/types/alertPolicyServiceNowTable",
      "tmod:@turbot/servicenow-gcp-monitoring#/policy/types/groupServiceNowTable",
      "tmod:@turbot/servicenow-gcp-monitoring#/policy/types/notificationChannelServiceNowTable"
    ],
    servicenow-gcp-network = [
      "tmod:@turbot/servicenow-gcp-network#/policy/types/addressServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/backendBucketServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/backendServiceServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/firewallServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/forwardingRuleServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/globalAddressServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/globalForwardingRuleServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/interconnectServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/networkServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/packetMirroringServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/regionBackendServiceServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/regionSslCertificateServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/regionTargetHttpsProxyServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/regionUrlMapServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/routeServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/routerServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/sslCertificateServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/sslPolicyServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/subnetworkServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/targetHttpsProxyServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/targetPoolServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/targetSslProxyServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/targetTcpProxyServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/targetVpnGatewayServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/urlMapServiceNowTable",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/vpnTunnelServiceNowTable"
    ],
    servicenow-gcp-pubsub = [
      "tmod:@turbot/servicenow-gcp-pubsub#/policy/types/snapshotServiceNowTable",
      "tmod:@turbot/servicenow-gcp-pubsub#/policy/types/subscriptionServiceNowTable",
      "tmod:@turbot/servicenow-gcp-pubsub#/policy/types/topicServiceNowTable"
    ],
    servicenow-gcp-run = [
      "tmod:@turbot/servicenow-gcp-run#/policy/types/serviceServiceNowTable"
    ],
    servicenow-gcp-scheduler = [
      "tmod:@turbot/servicenow-gcp-scheduler#/policy/types/jobServiceNowTable"
    ],
    servicenow-gcp-secretmanager = [
      "tmod:@turbot/servicenow-gcp-secretmanager#/policy/types/secretServiceNowTable"
    ],
    servicenow-gcp-spanner = [
      "tmod:@turbot/servicenow-gcp-spanner#/policy/types/databaseServiceNowTable",
      "tmod:@turbot/servicenow-gcp-spanner#/policy/types/instanceServiceNowTable"
    ],
    servicenow-gcp-sql = [
      "tmod:@turbot/servicenow-gcp-sql#/policy/types/backupServiceNowTable",
      "tmod:@turbot/servicenow-gcp-sql#/policy/types/databaseServiceNowTable",
      "tmod:@turbot/servicenow-gcp-sql#/policy/types/instanceServiceNowTable"
    ],
    servicenow-gcp-storage = [
      "tmod:@turbot/servicenow-gcp-storage#/policy/types/bucketServiceNowTable",
      "tmod:@turbot/servicenow-gcp-storage#/policy/types/objectServiceNowTable"
    ],
    servicenow-gcp-vertexai = [
      "tmod:@turbot/servicenow-gcp-vertexai#/policy/types/endpointServiceNowTable",
      "tmod:@turbot/servicenow-gcp-vertexai#/policy/types/notebookRuntimeTemplateServiceNowTable"
    ]
  }

  # Flatten the Table policies for installed mods
  servicenow_table_policies_gcp = flatten([
    for mod in var.servicenow_mod_list_gcp : local.servicenow_table_policy_map_gcp[mod] if contains(keys(local.servicenow_table_policy_map_gcp), mod)
  ])

  # Map of mods to their respective Configuration Items policies
  servicenow_configuration_item_policy_map_gcp = {
    servicenow-gcp = [
      "tmod:@turbot/servicenow-gcp#/policy/types/globalRegionServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp#/policy/types/multiRegionServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp#/policy/types/projectServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp#/policy/types/regionServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp#/policy/types/zoneServiceNowConfigurationItem"
    ],
    servicenow-gcp-appengine = [
      "tmod:@turbot/servicenow-gcp-appengine#/policy/types/applicationServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-appengine#/policy/types/firewallRuleServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-appengine#/policy/types/instanceServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-appengine#/policy/types/serviceServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-appengine#/policy/types/versionServiceNowConfigurationItem"
    ],
    servicenow-gcp-bigquery = [
      "tmod:@turbot/servicenow-gcp-bigquery#/policy/types/datasetServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-bigquery#/policy/types/tableServiceNowConfigurationItem"
    ],
    servicenow-gcp-bigtable = [
      "tmod:@turbot/servicenow-gcp-bigtable#/policy/types/clusterServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-bigtable#/policy/types/instanceServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-bigtable#/policy/types/tableServiceNowConfigurationItem"
    ],
    servicenow-gcp-composer = [
      "tmod:@turbot/servicenow-gcp-composer#/policy/types/environmentServiceNowConfigurationItem"
    ],
    servicenow-gcp-computeengine = [
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/computeProjectServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/diskServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/healthCheckServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/httpHealthCheckServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/httpsHealthCheckServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/imageServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/instanceServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/instanceTemplateServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/nodeGroupServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/nodeTemplateServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/regionDiskServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/regionHealthCheckServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/snapshotServiceNowConfigurationItem"
    ],
    servicenow-gcp-dataflow = [
      "tmod:@turbot/servicenow-gcp-dataflow#/policy/types/jobServiceNowConfigurationItem"
    ],
    servicenow-gcp-datapipeline = [
      "tmod:@turbot/servicenow-gcp-datapipeline#/policy/types/pipelineServiceNowConfigurationItem"
    ],
    servicenow-gcp-dataplex = [
      "tmod:@turbot/servicenow-gcp-dataplex#/policy/types/lakeServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-dataplex#/policy/types/taskServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-dataplex#/policy/types/zoneServiceNowConfigurationItem"
    ],
    servicenow-gcp-dataproc = [
      "tmod:@turbot/servicenow-gcp-dataproc#/policy/types/clusterServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-dataproc#/policy/types/jobServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-dataproc#/policy/types/workflowTemplateServiceNowConfigurationItem"
    ],
    servicenow-gcp-dns = [
      "tmod:@turbot/servicenow-gcp-dns#/policy/types/managedZoneServiceNowConfigurationItem"
    ],
    servicenow-gcp-firebase = [
      "tmod:@turbot/servicenow-gcp-firebase#/policy/types/androidAppServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-firebase#/policy/types/firebaseProjectServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-firebase#/policy/types/iosAppServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-firebase#/policy/types/webAppServiceNowConfigurationItem"
    ],
    servicenow-gcp-functions = [
      "tmod:@turbot/servicenow-gcp-functions#/policy/types/functionServiceNowConfigurationItem"
    ],
    servicenow-gcp-iam = [
      "tmod:@turbot/servicenow-gcp-iam#/policy/types/projectIamPolicyServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-iam#/policy/types/projectRoleServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-iam#/policy/types/projectUserServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-iam#/policy/types/serviceAccountKeyServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-iam#/policy/types/serviceAccountServiceNowConfigurationItem"
    ],
    servicenow-gcp-kms = [
      "tmod:@turbot/servicenow-gcp-kms#/policy/types/cryptoKeyServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-kms#/policy/types/keyRingServiceNowConfigurationItem"
    ],
    servicenow-gcp-kubernetesengine = [
      "tmod:@turbot/servicenow-gcp-kubernetesengine#/policy/types/regionClusterServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-kubernetesengine#/policy/types/regionNodePoolServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-kubernetesengine#/policy/types/zoneClusterServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-kubernetesengine#/policy/types/zoneNodePoolServiceNowConfigurationItem"
    ],
    servicenow-gcp-logging = [
      "tmod:@turbot/servicenow-gcp-logging#/policy/types/exclusionServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-logging#/policy/types/metricServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-logging#/policy/types/sinkServiceNowConfigurationItem"
    ],
    servicenow-gcp-memorystore = [
      "tmod:@turbot/servicenow-gcp-memorystore#/policy/types/instanceServiceNowConfigurationItem"
    ],
    servicenow-gcp-monitoring = [
      "tmod:@turbot/servicenow-gcp-monitoring#/policy/types/alertPolicyServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-monitoring#/policy/types/groupServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-monitoring#/policy/types/notificationChannelServiceNowConfigurationItem"
    ],
    servicenow-gcp-network = [
      "tmod:@turbot/servicenow-gcp-network#/policy/types/addressServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/backendBucketServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/backendServiceServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/firewallServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/forwardingRuleServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/globalAddressServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/globalForwardingRuleServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/interconnectServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/networkServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/packetMirroringServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/regionBackendServiceServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/regionSslCertificateServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/regionTargetHttpsProxyServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/regionUrlMapServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/routeServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/routerServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/sslCertificateServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/sslPolicyServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/subnetworkServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/targetHttpsProxyServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/targetPoolServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/targetSslProxyServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/targetTcpProxyServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/targetVpnGatewayServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/urlMapServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/vpnTunnelServiceNowConfigurationItem"
    ],
    servicenow-gcp-pubsub = [
      "tmod:@turbot/servicenow-gcp-pubsub#/policy/types/snapshotServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-pubsub#/policy/types/subscriptionServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-pubsub#/policy/types/topicServiceNowConfigurationItem"
    ],
    servicenow-gcp-run = [
      "tmod:@turbot/servicenow-gcp-run#/policy/types/serviceServiceNowConfigurationItem"
    ],
    servicenow-gcp-scheduler = [
      "tmod:@turbot/servicenow-gcp-scheduler#/policy/types/jobServiceNowConfigurationItem"
    ],
    servicenow-gcp-secretmanager = [
      "tmod:@turbot/servicenow-gcp-secretmanager#/policy/types/secretServiceNowConfigurationItem"
    ],
    servicenow-gcp-spanner = [
      "tmod:@turbot/servicenow-gcp-spanner#/policy/types/databaseServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-spanner#/policy/types/instanceServiceNowConfigurationItem"
    ],
    servicenow-gcp-sql = [
      "tmod:@turbot/servicenow-gcp-sql#/policy/types/backupServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-sql#/policy/types/databaseServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-sql#/policy/types/instanceServiceNowConfigurationItem"
    ],
    servicenow-gcp-storage = [
      "tmod:@turbot/servicenow-gcp-storage#/policy/types/bucketServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-storage#/policy/types/objectServiceNowConfigurationItem"
    ],
    servicenow-gcp-vertexai = [
      "tmod:@turbot/servicenow-gcp-vertexai#/policy/types/endpointServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-gcp-vertexai#/policy/types/notebookRuntimeTemplateServiceNowConfigurationItem"
    ],
  }

  # Flatten the Configuration Item policies for installed mods
  servicenow_configuration_item_policies_gcp = flatten([
    for mod in var.servicenow_mod_list_gcp : local.servicenow_configuration_item_policy_map_gcp[mod] if contains(keys(local.servicenow_configuration_item_policy_map_gcp), mod)
  ])

  # Map of mods to their respective relationshups policies
  servicenow_relationships_policy_map_gcp = {

    servicenow-gcp = [
      "tmod:@turbot/servicenow-gcp#/policy/types/globalRegionServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp#/policy/types/multiRegionServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp#/policy/types/projectServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp#/policy/types/regionServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp#/policy/types/zoneServiceNowRelationships"
    ],
    servicenow-gcp-appengine = [],
    servicenow-gcp-bigquery  = [],
    servicenow-gcp-bigtable  = [],
    servicenow-gcp-composer  = [],
    servicenow-gcp-computeengine = [
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/diskServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/imageServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/instanceServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/nodeGroupServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/nodeTemplateServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp-computeengine#/policy/types/snapshotServiceNowRelationships"
    ],
    servicenow-gcp-dataflow         = [],
    servicenow-gcp-datapipeline     = [],
    servicenow-gcp-dataplex         = [],
    servicenow-gcp-dataproc         = [],
    servicenow-gcp-dns              = [],
    servicenow-gcp-firebase         = [],
    servicenow-gcp-functions        = [],
    servicenow-gcp-iam              = [],
    servicenow-gcp-kms              = [],
    servicenow-gcp-kubernetesengine = [],
    servicenow-gcp-logging          = [],
    servicenow-gcp-memorystore      = [],
    servicenow-gcp-monitoring       = [],
    servicenow-gcp-network = [
      "tmod:@turbot/servicenow-gcp-network#/policy/types/firewallServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/forwardingRuleServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/networkServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/routeServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/routerServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/subnetworkServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/targetPoolServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp-network#/policy/types/targetVpnGatewayServiceNowRelationships"
    ],
    servicenow-gcp-pubsub        = [],
    servicenow-gcp-run           = [],
    servicenow-gcp-scheduler     = [],
    servicenow-gcp-secretmanager = [],
    servicenow-gcp-spanner       = [],
    servicenow-gcp-sql           = [],
    servicenow-gcp-storage = [
      "tmod:@turbot/servicenow-gcp-storage#/policy/types/bucketServiceNowRelationships",
      "tmod:@turbot/servicenow-gcp-storage#/policy/types/objectServiceNowRelationships"
    ],
    servicenow-gcp-vertexai = [],
  }

  # Flatten the Relationships policies for installed mods
  servicenow_relationships_policies_gcp = flatten([
    for mod in var.servicenow_mod_list_gcp : local.servicenow_relationships_policy_map_gcp[mod] if contains(keys(local.servicenow_relationships_policy_map_gcp), mod)
  ])

}


