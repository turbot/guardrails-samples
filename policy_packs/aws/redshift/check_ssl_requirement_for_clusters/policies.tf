# AWS > Redshift > Cluster > Approved
resource "turbot_policy_setting" "aws_redshift_cluster_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-redshift#/policy/types/clusterApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > Redshift > Cluster > Approved > Custom
resource "turbot_policy_setting" "aws_redshift_cluster_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-redshift#/policy/types/clusterApprovedCustom"
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
  template       = <<-EOT
    {%- if $.parameterGroup == null -%}

      {%- set data = {
          "title": "Require SSL",
          "result": "Skip",
          "message": "Parameter group data is not available yet"
      } -%}

    {%- else -%}

      {%- set requireSslParameter = {} -%}

      {%- for parameter in $.parameterGroup.parameters -%}

        {%- if parameter.ParameterName == 'require_ssl' -%}

          {%- set requireSslParameter = parameter -%}

        {%- endif -%}

      {%- endfor -%}

      {%- set requireSslParameterStatus = {} -%}

      {%- for parameterGroup in $.clusterParameterStatusList -%}

        {%- if parameterGroup.ParameterName == 'require_ssl' -%}

          {%- set requireSslParameterStatus = parameterGroup -%}

        {%- endif -%}

      {%- endfor -%}

      {%- if requireSslParameter and requireSslParameter.ParameterValue == 'true' and requireSslParameterStatus and requireSslParameterStatus.ParameterApplyStatus == 'in-sync' -%}

        {%- set data = {
            "title": "Require SSL",
            "result": "Approved",
            "message": "The require_ssl parameter is set to true and is in-sync"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "Require SSL",
            "result": "Not approved",
            "message": "The require_ssl parameter is not set to true or not in-sync"
        } -%}

      {%- endif -%}

    {%- endif -%}

    {{ data | json }}
    EOT
}
