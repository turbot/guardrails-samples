# GCP > Vertex AI > Endpoint > Allowed > Encryption at Rest
resource "turbot_policy_setting" "gcp_vertexai_endpoint_allowed_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-vertexai#/policy/types/endpointAllowedEncryptionAtRest"
  value    = "Check: Allowed encryption level"
  # value    = "Enforce: Delete if encryption level not allowed and resource is new"
}

# GCP > Vertex AI > Endpoint > Allowed > Encryption at Rest > Level
resource "turbot_policy_setting" "gcp_vertexai_endpoint_allowed_encryption_at_rest_level" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-vertexai#/policy/types/endpointAllowedEncryptionAtRestLevel"
  value    = "Customer managed key"
  # value    = "Google managed key"
  # value    = "Google managed key or higher"
}

# GCP > Vertex AI > Endpoint > Allowed > Encryption at Rest > Level > Customer Managed Key
#
# The customer managed key requires an environment-specific GCP KMS key path. Uncomment and
# set this to the KMS key you want to enforce for endpoint encryption at rest.
#
# resource "turbot_policy_setting" "gcp_vertexai_endpoint_allowed_encryption_at_rest_customer_managed_key" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/gcp-vertexai#/policy/types/endpointAllowedEncryptionAtRestCustomerManagedKey"
#   value    = "<your-kms-key-path>"
# }
