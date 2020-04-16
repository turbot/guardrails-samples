### Create the GCP > Project resource in Turbot
resource "turbot_resource" "project_resource" {
  parent = var.parent_resource
  type   = "tmod:@turbot/gcp#/resource/types/project"
  metadata = jsonencode({
    "gcp" : {
      "projectId" : var.gcp_project_id
    }
  })
  data = jsonencode({
    "projectId" : var.gcp_project_id
  })
}

resource "turbot_policy_setting" "clientEmail" {
  resource = var.parent_resource
  type     = "tmod:@turbot/gcp#/policy/types/clientEmail"
  value    = var.client_email
}

resource "turbot_policy_setting" "privateKey" {
  resource = var.parent_resource
  type     = "tmod:@turbot/gcp#/policy/types/privateKey"
  value    = var.private_key
}
