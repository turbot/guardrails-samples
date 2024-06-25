---
organization: Turbot
category: ["public cloud"]
icon_url: "/images/plugins/turbot/gcp.svg"
brand_color: "#FF9900" # TODO: verify the brand_color
display_name: "Enforce GCP KMS Cryptographic Keys to Not Be Publicly Accessible"
short_name: "enforce_crypto_keys_to_not_be_publicly_accessible"
description: "Ensure that there are no publicly accessible GCP KMS cryptographic keys available within the project."
mod_dependencies:
  - "@turbot/gcp"
  - "@turbot/gcp-iam"
  - "@turbot/gcp-kms"
---
