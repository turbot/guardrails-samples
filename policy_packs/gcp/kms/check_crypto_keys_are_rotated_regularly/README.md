---
organization: Turbot
category: ["public cloud"]
icon_url: "/images/plugins/turbot/gcp.svg"
brand_color: "#FF9900" # TODO: verify the brand_color
display_name: "Check If GCP KMS Crypto Keys Are Rotated Regularly"
short_name: "check_crypto_keys_are_rotated_regularly"
description: "Check if GCP KMS cryptographic keys available within the project are rotated regularly."
mod_dependencies:
  - "@turbot/gcp"
  - "@turbot/gcp-iam"
  - "@turbot/gcp-kms"
---
