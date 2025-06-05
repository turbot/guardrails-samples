# AWS > EKS > Cluster > Approved
# Main policy that controls what happens when EKS clusters are not approved
resource "turbot_policy_setting" "aws_eks_cluster_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-eks#/policy/types/clusterApproved"
  value    = "Check: Approved"

  # Uncomment one of the following values to change the behavior:
  # value    = "Enforce: Delete unapproved if new"  # Delete unapproved clusters if created within last 60 minutes
  # value    = "Skip"                               # Skip checking cluster approval
}

# AWS > EKS > Cluster > Approved > Custom
# Sub-policy that checks for public access configuration
resource "turbot_policy_setting" "aws_eks_cluster_public_access" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-eks#/policy/types/clusterApprovedCustom"
  template_input = <<-EOT
  {
    resource {
      publicAccess: get(path: "resourcesVpcConfig.endpointPublicAccess")
      publicCidrs: get(path: "resourcesVpcConfig.publicAccessCidrs")
      clusterName: get(path: "name")
    }
  }
  EOT
  template       = <<-EOT
  {%- if $.resource.publicAccess == null -%}
    {%- set data = {
        "title": "Public Access",
        "result": "Skip",
        "message": "Could not determine the public access configuration. Please verify the cluster configuration."
    } -%}
  {%- elif $.resource.publicAccess == true -%}
    {%- set hasOpenCidr = false -%}
    {%- for cidr in $.resource.publicCidrs -%}
      {%- if cidr == "0.0.0.0/0" -%}
        {%- set hasOpenCidr = true -%}
      {%- endif -%}
    {%- endfor -%}
    {%- if hasOpenCidr -%}
      {%- if $.resource.clusterName -%}
        {%- set data = {
            "title": "Public Access",
            "result": "Not approved",
            "message": "Cluster " + $.resource.clusterName + " has unrestricted public endpoint access (0.0.0.0/0)"
        } -%}
      {%- else -%}
        {%- set data = {
            "title": "Public Access",
            "result": "Not approved",
            "message": "Cluster has unrestricted public endpoint access (0.0.0.0/0)"
        } -%}
      {%- endif -%}
    {%- else -%}
      {%- if $.resource.clusterName -%}
        {%- set data = {
            "title": "Public Access",
            "result": "Approved",
            "message": "Cluster " + $.resource.clusterName + " has restricted public endpoint access: " + $.resource.publicCidrs | join(", ")
        } -%}
      {%- else -%}
        {%- set data = {
            "title": "Public Access",
            "result": "Approved",
            "message": "Cluster has restricted public endpoint access: " + $.resource.publicCidrs | join(", ")
        } -%}
      {%- endif -%}
    {%- endif -%}
  {%- else -%}
    {%- if $.resource.clusterName -%}
      {%- set data = {
          "title": "Public Access",
          "result": "Approved",
          "message": "Cluster " + $.resource.clusterName + " has public endpoint access disabled"
      } -%}
    {%- else -%}
      {%- set data = {
          "title": "Public Access",
          "result": "Approved",
          "message": "Cluster has public endpoint access disabled"
      } -%}
    {%- endif -%}
  {%- endif -%}
  {{ data | json }}
  EOT
}
