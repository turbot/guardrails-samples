---
organization: Turbot
category: ["public cloud"]
icon_url: "/images/plugins/turbot/gcp.svg"
brand_color: "#FF9900" # TODO: verify the brand_color
display_name: "Enforce GCP VPC Network Firewall Rules with Range of Ports to not allow incoming traffic"
short_name: "enforce_firewall_rule_with_port_range_to_not_allow_incoming_traffic"
description: "Delete GCP VPC network firewall rules with range of ports that are opened to allow incoming traffic."
mod_dependencies:
  - "@turbot/gcp"
  - "@turbot/gcp-iam"
  - "@turbot/gcp-network"
---
