# # AWS > EKS > Enabled
# resource "turbot_policy_setting" "aws_eks_enabled" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-eks#/policy/types/eksEnabled"
#   value    = "Enabled"
# }

# AWS > EKS > Cluster > Approved
resource "turbot_policy_setting" "aws_eks_cluster_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-eks#/policy/types/clusterApproved"
  value    = "Check: Approved"
  # value = "Enforce: Delete unapproved if new"
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
{# =============================================================================
   EKS Deny Public Resources Policy Logic

   This template implements a three-tier decision process for EKS cluster approval:
   1. Check for exception tag (highest priority)
   2. Check public access setting (if no exception)
   3. Default to private access approval
   ============================================================================= #}

{# Extract tags from the resource, defaulting to empty object if none exist #}
{% set tags_map = $.resource.turbot.tags or {} %}

{# Get the specific exception tag value #}
{% set tag_val = tags_map["turbot:deny-public-resources:exception"] %}

{# Check if exception tag exists and equals "true" (case-insensitive) #}
{% set hasExceptionTag = tag_val and tag_val | lower == "true" %}

{# =============================================================================
   DECISION LOGIC - Three-tier evaluation process
   ============================================================================= #}

{% if hasExceptionTag %}
  {# TIER 1: Exception tag present - Always approve regardless of public access #}
  {% set data = {
    "title": "Exception Tag Present",
    "result": "Approved",
    "message": "EKS cluster is tagged to skip deny-public-resources control"
  } %}
{% elif $.resource.publicAccess == true %}
  {# TIER 2: No exception tag + Public access enabled - Deny for security #}
  {% set data = {
    "title": "Public Access",
    "result": "Not approved",
    "message": "EKS cluster {{ $.resource.identifier }} has public endpoint access"
  } %}
{% else %}
  {# TIER 3: No exception tag + Private access only - Approve as secure #}
  {% set data = {
    "title": "Private Access",
    "result": "Approved",
    "message": "EKS cluster has private endpoint access"
  } %}
{% endif %}

{# Output the decision as JSON for Guardrails processing #}
{{ data | json }}
EOT
}
