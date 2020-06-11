
aws redshift describe-clusters \
        --region us-east-1 \
        --cluster-identifier cc-cluster \
        --query 'Clusters[*].ClusterParameterGroups[*].ParameterGroupName[]'

aws redshift describe-cluster-parameters --region us-east-1 --parameter-group-name ssl-parameter-group
        --cluster-identifier cc-cluster \
        --query 'Clusters[*].ClusterParameterGroups[*].ParameterGroupName[]'



describe-cluster-parameter-groups
describe-cluster-parameters
describe-default-cluster-parameters


    "ParameterGroups": [
{
    "ParameterGroupName": "default.redshift-1.0",
    "ParameterGroupFamily": "redshift-1.0",
    "Description": "Default parameter group for redshift-1.0",
    "Tags": []
},
{
    "ParameterGroupName": "ssl-param-group",
    "ParameterGroupFamily": "redshift-1.0",
    "Description": "with ssl",
    "Tags": []
}



# variables:
#   input:
#     parent: '173745281538957'
#     type: '#/resource/types/clusterParameterGroup'
#     data:
#       ParameterGroupName: ssl-param-group
#       ParameterGroupFamily: redshift-1.0
#       Description: with ssl
#       Tags: []
#     metadata:
#       aws:
#         accountId: '235268162285'
#         partition: aws
#         regionName: us-east-1
#     actor: {}


# {
#   function {
#     role: get(path: "Role")
#   }
#   iamRoles: resources(filter: "resourceType:'tmod:@turbot/aws-iam#/resource/types/role' level:'self'") {
#     items {
#       arn: get(path: "Arn")
#     }
#   }
# }








ClusterParameterGroups:
  - ClusterParameterStatusList: []
    ParameterApplyStatus: in-sync
    ParameterGroupName: default.redshift-1.0

{
  "cluster": {
    "parameterGroups": [
      {
        "ParameterGroupName": "ecrypted-pg",
        "ParameterApplyStatus": "in-sync",
        "ClusterParameterStatusList": [
          {
            "ParameterName": "enable_user_activity_logging",
            "ParameterApplyStatus": "in-sync"
          },
          {
            "ParameterName": "auto_analyze",
            "ParameterApplyStatus": "in-sync"
          },
          {
            "ParameterName": "max_cursor_result_set_size",
            "ParameterApplyStatus": "in-sync"
          },
          {
            "ParameterName": "query_group",
            "ParameterApplyStatus": "in-sync"
          },
          {
            "ParameterName": "datestyle",
            "ParameterApplyStatus": "in-sync"
          },
          {
            "ParameterName": "extra_float_digits",
            "ParameterApplyStatus": "in-sync"
          },
          {
            "ParameterName": "search_path",
            "ParameterApplyStatus": "in-sync"
          },
          {
            "ParameterName": "statement_timeout",
            "ParameterApplyStatus": "in-sync"
          },
          {
            "ParameterName": "wlm_json_configuration",
            "ParameterApplyStatus": "in-sync"
          },
          {
            "ParameterName": "require_ssl",
            "ParameterApplyStatus": "in-sync"
          },
          {
            "ParameterName": "use_fips_ssl",
            "ParameterApplyStatus": "in-sync"
          },
          {
            "ParameterName": "max_concurrency_scaling_clusters",
            "ParameterApplyStatus": "in-sync"
          }
        ]
      }
    ]
  }
}
