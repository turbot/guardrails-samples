# Azure > AKS > ManagedCluster > Approved
resource "turbot_policy_setting" "azure_aks_managedcluster_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-aks#/policy/types/managedClusterApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > AKS > ManagedCluster > custom
resource "turbot_policy_setting" "azure_aks_managedcluster_approved_custom" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/azure-aks#/policy/types/managedClusterApprovedCustom"
  template_input = <<-EOT
    {
      managedCluster {
        enableRBAC: get(path:"enableRBAC")
      }
    }
    EOT
  template       = <<-EOT
    title: "Detect If RBAC is enabled for managed Cluster"
    {%- if $.managedCluster.enableRBAC %}
    result: Approved
    message: "RBAC is enabled for managed Cluster"
    {%- else -%}
    result: Not approved
    message: "RBAC is disabled for managed Cluster"
    {%- endif -%}
    EOT
}
