---
organization: Turbot
category: ["public cloud"]
icon_url: "/images/plugins/turbot/gcp.svg"
brand_color: "#FF9900" # TODO: verify the brand_color
display_name: "Enforce Encryption for Secrets is Enabled for GCP GKE Clusters"
short_name: "enforce_encryption_for_secrets_is_enabled_for_clusters"
description: "Delete GCP GKE clusters that do not have encryption for secrets enabled."
mod_dependencies:
  - "@turbot/gcp"
  - "@turbot/gcp-iam"
  - "@turbot/gcp-kubernetesengine"
---
