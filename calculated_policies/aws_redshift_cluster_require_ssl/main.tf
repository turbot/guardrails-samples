# resource "turbot_smart_folder" "aws_redshift_cluster_require_ssl" {
#   title         = var.smart_folder_title
#   description   = "Enables bucket versioning for all buckets tagged with {Environment:=Prod}"
#   parent        = "tmod:@turbot/turbot#/"
# }

resource "turbot_policy_setting" "aws_redshift_cluster_require_ssl" {
  # resource = turbot_smart_folder.aws_s3_bucket_encryption_at_rest_customer_managed_key_tags_match.id
  resource   = "191926035367605"
  type       = "tmod:@turbot/aws-redshift#/policy/types/clusterApproved"
  value    = "Check: Approved"
}

resource "turbot_policy_setting" "aws_redshift_cluster_require_ssl_usage" {
  # resource   = turbot_smart_folder.aws_redshift_cluster_require_ssl.id
  resource   = "191926035367605"
  type       = "tmod:@turbot/aws-redshift#/policy/types/clusterApprovedUsage"
  # GraphQL to pull instance tags
  template_input = <<EOT
    - |
      {
        item: resource {
          parameterGroupName: get(path: "ClusterParameterGroups[0].ParameterGroupName")
          turbot {
            custom
          }
        }
      }
    - |
      {
        cluster: resource {
          parameterGroup: get(path: "ClusterParameterGroups[0]")
        }
        parameterGroup: resource (id: "arn:aws:redshift:{{ $.item.turbot.custom.aws.regionName }}:{{ $.item.turbot.custom.aws.accountId }}:parametergroup:{{ $.item.parameterGroupName }}") {
          parameters: get(path:"Parameters")
        }
      }
  EOT

  # Nunjucks Template
  template      = <<EOT
    {%- set requireSslParameter = {} -%}
    {%- for parameter in $.parameterGroup.parameters -%}
      {%- if parameter.ParameterName == 'require_ssl' -%}
        {%- set requireSslParameter = parameter -%}
      {%- endif -%}
    {%- endfor -%}

    {%- set requireSslParameterStatus = {} -%}
    {%- for parameterGroup in $.cluster.parameterGroup.ClusterParameterStatusList -%}
      {%- if parameterGroup.ParameterName == 'require_ssl' -%}
        {%- set requireSslParameterStatus = parameterGroup -%}
      {%- endif -%}
    {%- endfor -%}

    {%- if requireSslParameter
          and requireSslParameter.ParameterValue == 'true'
          and requireSslParameterStatus
          and requireSslParameterStatus.ParameterApplyStatus == 'in-sync' -%}
      Approved
    {%- else -%}
      Not approved
    {%- endif -%}
  EOT
}
