---
categories: ["security"]
description: "Enforcing encryption at rest for AWS EBS volumes is critical to protect sensitive data from unauthorized access and potential breaches."
---

# Enforce Encryption at Rest is Enabled for AWS EBS Volumes

Enforcing encryption at rest for AWS EBS volumes is critical to protect sensitive data from unauthorized access and potential breaches. This measure ensures that data stored on EBS volumes is encrypted, thereby enhancing data security and compliance with regulatory requirements.

## Documentation

- **[Policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/enforce_encryption_at_rest_is_enabled_for_ebs_volumes/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- The following Guardrails mods need to be installed:
  - [@turbot/aws-ec2](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-ec2)

### Credentials

To create a policy pack through Terraform:

- Ensure you have `Turbot/Owner` or `Turbot/Admin` permissions in Guardrails
- Create [Guardrails access keys](https://turbot.com/guardrails/docs/guides/iam/access-keys#generate-a-new-guardrails-api-access-key)

And then set your credentials:

```sh
export TURBOT_WORKSPACE=myworkspace-turbot.cloud.turbot.com
export TURBOT_ACCESS_KEY=acce6ac5-access-key-here
export TURBOT_SECRET_KEY=a8af61ec-secret-key-here
```

Please check [Turbot Guardrails Provider authentication](https://registry.terraform.io/providers/turbot/turbot/latest/docs#authentication) for additional authentication methods.

## Usage

Clone:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/aws/ec2/enforce_encryption_at_rest_is_enabled_for_ebs_volumes
```

Run the Terraform to create the policy pack in your workspace:

```sh
terraform init
terraform plan
```

Then apply the changes:

```sh
terraform apply
```

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/working-with-folders/smart#attach-a-smart-folder-to-a-resource).

### Enable Enforcement

By default, the controls are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "aws_ec2_volume_approved" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/volumeApproved"
  # value          = "Check: Approved"
  value          =  "Enforce: Detach unapproved if new"
  # value          =  "Enforce: Detach, snapshot and delete unapproved if new"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```

You can also update the policy setting on the policy pack directly in the Guardrails console.

Note: If modifying the policy setting in the console, your Terraform state file will become out of sync, so the policy settings should only be managed in the console.
