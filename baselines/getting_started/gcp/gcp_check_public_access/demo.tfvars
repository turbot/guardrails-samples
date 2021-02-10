# List of services and resources to set the Trusted Access policy
# Assuming all for the initial baseline
# You can remove the comment per row to include the resource type.  Make sure you have the related service mod installed

  policy_map  = {
    "gcp-bigtable-instance"              = "tmod:@turbot/gcp-bigtable#/policy/types/instancePolicyTrustedAccess"
    "gcp-computeengine-disk"             = "tmod:@turbot/gcp-computeengine#/policy/types/diskPolicyTrustedAccess"
    "gcp-computeengine-image"            = "tmod:@turbot/gcp-computeengine#/policy/types/imagePolicyTrustedAccess"
    "gcp-computeengine-instance"         = "tmod:@turbot/gcp-computeengine#/policy/types/instancePolicyTrustedAccess"
    "gcp-computeengine-instanceTemplate" = "tmod:@turbot/gcp-computeengine#/policy/types/instanceTemplatePolicyTrustedAccess"
    "gcp-computeengine-nodeGroup"        = "tmod:@turbot/gcp-computeengine#/policy/types/nodeGroupPolicyTrustedAccess"
    "gcp-computeengine-nodeTemplate"     = "tmod:@turbot/gcp-computeengine#/policy/types/nodeTemplatePolicyTrustedAccess"
    "gcp-dataproc-cluster"               = "tmod:@turbot/gcp-dataproc#/policy/types/clusterPolicyTrustedAccess"
    "gcp-dataproc-job"                   = "tmod:@turbot/gcp-dataproc#/policy/types/jobPolicyTrustedAccess"
    "gcp-dataproc-workflowTemplate"      = "tmod:@turbot/gcp-dataproc#/policy/types/workflowTemplatePolicyTrustedAccess"
    "gcp-functions-function"             = "tmod:@turbot/gcp-functions#/policy/types/functionPolicyTrustedAccess"
    "gcp-iam-projectIam"                 = "tmod:@turbot/gcp-iam#/policy/types/projectIamPolicyTrustedAccess"
    "gcp-iam-serviceAccountPolicy"       = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountPolicyTrustedAccess"
    "gcp-kms-cryptoKey"                  = "tmod:@turbot/gcp-kms#/policy/types/cryptoKeyPolicyTrustedAccess"
    "gcp-kms-keyRing"                    = "tmod:@turbot/gcp-kms#/policy/types/keyRingPolicyTrustedAccess"
    "gcp-network-subnetwork"             = "tmod:@turbot/gcp-network#/policy/types/subnetworkPolicyTrustedAccess"
    "gcp-pubsub-subscription"            = "tmod:@turbot/gcp-pubsub#/policy/types/subscriptionPolicyTrustedAccess"
    "gcp-pubsub-topic"                   = "tmod:@turbot/gcp-pubsub#/policy/types/topicPolicyTrustedAccess"
    "gcp-spanner-instance"               = "tmod:@turbot/gcp-spanner#/policy/types/instancePolicyTrustedAccess"
    "gcp-storage-bucket"                 = "tmod:@turbot/gcp-storage#/policy/types/bucketPolicyTrustedAccess"
  }