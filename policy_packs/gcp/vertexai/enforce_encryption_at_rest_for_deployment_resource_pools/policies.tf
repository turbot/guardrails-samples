# GCP > Vertex AI > Deployment Resource Pool > Allowed > Encryption at Rest
resource "turbot_policy_setting" "gcp_vertexai_deployment_resource_pool_allowed_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-vertexai#/policy/types/deploymentResourcePoolAllowedEncryptionAtRest"
  value    = "Check: Allowed encryption level"
  # value    = "Enforce: Delete if encryption level not allowed and resource is new"
}

# GCP > Vertex AI > Deployment Resource Pool > Allowed > Encryption at Rest > Level
resource "turbot_policy_setting" "gcp_vertexai_deployment_resource_pool_allowed_encryption_at_rest_level" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-vertexai#/policy/types/deploymentResourcePoolAllowedEncryptionAtRestLevel"
  value    = "Customer managed key"
  # value    = "Google managed key"
  # value    = "Google managed key or higher"
}

# GCP > Vertex AI > Deployment Resource Pool > Allowed > Encryption at Rest > Level > Customer Managed Key
#
# The customer managed key requires an environment-specific GCP KMS key path. Uncomment and
# set this to the KMS key you want to enforce for deployment resource pool encryption at rest.
#
# resource "turbot_policy_setting" "gcp_vertexai_deployment_resource_pool_allowed_encryption_at_rest_customer_managed_key" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/gcp-vertexai#/policy/types/deploymentResourcePoolAllowedEncryptionAtRestCustomerManagedKey"
#   value    = "<your-kms-key-path>"
# }
