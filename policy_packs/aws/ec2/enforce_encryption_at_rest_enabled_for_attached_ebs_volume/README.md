---
organization: Turbot
category: ["public cloud"]
icon_url: "/images/plugins/turbot/aws.svg"
brand_color: "#FF9900"
display_name: "Enforce Encryption at Rest is Enabled for AWS EBS Volumes Attached to AWS EC2 Instances"
short_name: "enforce_encryption_at_rest_enabled_for_attached_ebs_volume"
description: "Detach/Snapshot and delete attached AWS EBS volumes that do not have encryption at rest enabled."
mod_dependencies:
  - "@turbot/aws"
  - "@turbot/aws-iam"
  - "@turbot/aws-ec2"
---
