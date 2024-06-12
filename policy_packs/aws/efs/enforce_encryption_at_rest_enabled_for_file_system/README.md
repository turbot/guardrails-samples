---
organization: Turbot
category: ["public cloud"]
icon_url: "/images/plugins/turbot/aws.svg"
brand_color: "#FF9900"
display_name: "Enforce Encryption at Rest is Enabled for AWS EFS File Systems"
short_name: "enforce_encryption_at_rest_enabled_for_file_system"
description: "Delete AWS EFS file systems that do not have encryption at rest enabled."
mod_dependencies:
  - "@turbot/aws"
  - "@turbot/aws-iam"
  - "@turbot/aws-efs"
---
