# Azure > AKS > Managed Cluster > Approved
resource "turbot_policy_setting" "azure_aks_managed_cluster_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-aks#/policy/types/managedClusterApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > AKS > Managed Cluster > Custom
resource "turbot_policy_setting" "azure_aks_managed_cluster_approved_custom" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/azure-aks#/policy/types/managedClusterApprovedCustom"
  template_input = <<-EOT
    {
      managedCluster {
        enableRBAC: get(path: "enableRBAC")
      }
    }
    EOT
  template       = <<-EOT
    title: "RBAC Enabled"
    {%- if $.managedCluster.enableRBAC %}
        result: Approved
        message: "RBAC is enabled for managed cluster"
    {%- else -%}
        result: Not approved
        message: "RBAC is not enabled for managed cluster"
    {%- endif -%}
    EOT
}
