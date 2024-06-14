---
organization: Turbot
category: ["public cloud"]
icon_url: "/images/plugins/turbot/aws.svg"
brand_color: "#FF9900"
display_name: "Enforce AWS DMS Replication Instances to Restrict Public Access"
short_name: "enforce_replication_instance_to_not_be_publicly_accessible"
description: "Stop/Terminate AWS DMS replication instances if they are are publicly accessible."
mod_dependencies:
  - "@turbot/aws"
  - "@turbot/aws-iam"
  - "@turbot/aws-dms"
---
