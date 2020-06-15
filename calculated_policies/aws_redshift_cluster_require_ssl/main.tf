# Smart Folder Definition
resource "turbot_smart_folder" "aws_redshift_cluster_require_ssl" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > Redshift > Cluster > Approved
resource "turbot_policy_setting" "aws_redshift_cluster_approved_usage_require_ssl_approved" {
  resource = turbot_smart_folder.aws_redshift_cluster_require_ssl.id
  type     = "tmod:@turbot/aws-redshift#/policy/types/clusterApproved"
  value    = "Check: Approved"
}

# AWS > Redshift > Cluster > Approved > Usage
resource "turbot_policy_setting" "aws_redshift_cluster_require_ssl_approved_usage" {
  resource       = turbot_smart_folder.aws_redshift_cluster_require_ssl.id
  type           = "tmod:@turbot/aws-redshift#/policy/types/clusterApprovedUsage"
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
  template = <<EOT
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

# Attach Smart Folder
resource "turbot_smart_folder_attachment" "aws_redshift_cluster_require_ssl_attachment" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.aws_redshift_cluster_require_ssl.id
}
