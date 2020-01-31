resource "turbot_smart_folder" "development_env_cost_savings" {
  title         = var.smart_folder_title
  description   = "Enables cool storage tier for storage account labeled with  {Environment:=Dev}"
  parent        = "tmod:@turbot/turbot#/"
}

resource "turbot_policy_setting" "azure_storage_account_tier" {
  resource   = turbot_smart_folder.development_env_cost_savings.id
  type       = "tmod:@turbot/azure-storage#/policy/types/storageAccountAccessTier"
  # GraphQL to pull resource tags
  template_input = <<EOT
    { 
        resource {
            tags
        }
    }
  EOT
  # Nunjucks template to set the storage tier based on a tag value
  template      = <<EOT
    {%- if $.storageAccount.turbot.tags.Environment == "Dev"%}
      "Enforce: Cool"
    {%- else -%}
      "Enforce: Hot"
    {%- endif -%}
  EOT
}

resource "turbot_policy_setting" "s3_bucket_versioning" {
  resource   = turbot_smart_folder.development_env_cost_savings.id
  type       = "tmod:@turbot/aws-s3#/policy/types/bucketVersioning"
  # GraphQL to pull resource tags
  template_input = <<EOT
    { 
        resource {
            tags
        }
    }
  EOT
  # Nunjucks Template
  template      = <<EOT
    {% if $.resource.tags.Environment == "Dev" %}
    "Enforce: Disabled"
    {% else %}
    "Enforce: Enabled"
    {% endif %}
  EOT
}