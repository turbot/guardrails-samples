# Azure > AKS > Managed Cluster > Approved
resource "turbot_policy_setting" "azure_aks_managed_cluster_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-aks#/policy/types/managedClusterApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > AKS > Managed Cluster > Custom
resource "turbot_policy_setting" "azure_aks_managed_cluster_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/azure-aks#/policy/types/managedClusterApprovedCustom"
  template_input = <<-EOT
    {
      managedCluster {
        enableRBAC: get(path: "enableRBAC")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.managedCluster.enableRBAC == false -%}

      {%- set data = {
          "title": "RBAC Enabled",
          "result": "Not approved",
          "message": "RBAC is not enabled for managed cluster"
      } -%}

    {%- elif $.managedCluster.enableRBAC == true -%}

      {%- set data = {
          "title": "RBAC Enabled",
          "result": "Approved",
          "message": "RBAC is enabled for managed cluster"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "RBAC Enabled",
          "result": "Skip",
          "message": "No RBAC data for managed cluster yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
    EOT
}
