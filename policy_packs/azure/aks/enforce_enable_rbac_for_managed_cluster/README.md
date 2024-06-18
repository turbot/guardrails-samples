---
organization: Turbot
category: ["public cloud"]
icon_url: "/images/plugins/turbot/azure.svg"
brand_color: "#FF9900" # TODO: verify the brand_color
display_name: "Enforce Enable RBAC for Azure AKS Managed Clusters"
short_name: "enforce_enable_rbac_for_managed_cluster"
description: "Delete Azure AKS managed clusters that do not have role-based access control enabled."
mod_dependencies:
  - "@turbot/azure"
  - "@turbot/azure-iam"
  - "@turbot/azure-provider"
  - "@turbot/azure-aks"
---
