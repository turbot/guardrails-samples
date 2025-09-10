# AWS > EKS > Enabled
resource "turbot_policy_setting" "aws_eks_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-eks#/policy/types/eksEnabled"
  value    = "Enabled"
}

# AWS > EKS > Cluster > Approved
resource "turbot_policy_setting" "aws_eks_cluster_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-eks#/policy/types/clusterApproved"
  # value    = "Check: Approved"
  value = "Enforce: Delete unapproved if new"
}

# AWS > EKS > Cluster > Approved > Custom
resource "turbot_policy_setting" "aws_eks_cluster_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-eks#/policy/types/clusterApprovedCustom"
  template_input = <<EOT
{
  resource {
    publicAccess: get(path: "resourcesVpcConfig.endpointPublicAccess")
    identifier: get(path: "name")
    turbot {
      tags
    }
  }
}
EOT
  template       = <<EOT
{% set tags_map = $.resource.turbot.tags or {} %}
{% set tag_val = tags_map["turbot:deny-public-resources:exception"] %}
{% set hasExceptionTag = tag_val and tag_val | lower == "true" %}

{% if hasExceptionTag %}
  {% set data = {
    "title": "Exception Tag Present",
    "result": "Approved",
    "message": "EKS cluster is tagged to skip deny-public-resources control"
  } %}
{% elif $.resource.publicAccess == true %}
  {% set data = {
    "title": "Public Access",
    "result": "Not approved",
    "message": "EKS cluster {{ $.resource.identifier }} has public endpoint access"
  } %}
{% else %}
  {% set data = {
    "title": "Private Access",
    "result": "Approved",
    "message": "EKS cluster has private endpoint access"
  } %}
{% endif %}
{{ data | json }}
EOT
}
