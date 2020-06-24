### Create the GCP > Project resource in Turbot
resource "turbot_resource" "project_resource" {
  parent = var.parent_resource
  type   = "tmod:@turbot/gcp#/resource/types/project"
  metadata = jsonencode({
    "gcp" : {
      "projectId" : var.gcp_project_id # this is client_id in the pem that GCP gives you in your service account's JSON private key
    }
  })
  data = jsonencode({
    "projectId" : var.gcp_project_id # this is client_id in the pem that GCP gives you in your service account's JSON private key
  })
}

resource "turbot_policy_setting" "clientEmail" {
  resource = turbot_resource.project_resource.id
  type     = "tmod:@turbot/gcp#/policy/types/clientEmail"
  value    = var.client_email
}

resource "turbot_policy_setting" "privateKey" {
  resource = turbot_resource.project_resource.id
  type     = "tmod:@turbot/gcp#/policy/types/privateKey"
  value    = var.private_key
}
