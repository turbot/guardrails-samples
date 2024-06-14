---
categories: ["security"]
display_name: "Enforce IMDSv2 on AWS EC2 Instances"
short_name: "enforce_imdsv2_for_instances"
description: "Mitigate the risk of unauthorized metadata exposure through vulnerabilities like Server-Side Request Forgery (SSRF)."
mod_dependencies:
  - "@turbot/aws-ec2"
---

# Enforce IMDSv2 on AWS EC2 Instances

Enforcing IMDSv2 on AWS EC2 instances enhances security by requiring session-based authentication to access instance metadata, mitigating the risk of unauthorized metadata exposure through vulnerabilities like SSRF (Server-Side Request Forgery). This helps ensure that only authorized applications and users can retrieve sensitive instance data.

## Documentation

- **[Policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/enforce_imdsv2_for_instances/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- The following Guardrails mods need to be installed:
  - [@turbot/aws-ec2](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/mods/aws/aws-ec2)

### Credentials

To create a policy pack through Terraform, setup your [Turbot Guardrails CLI credentials](https://turbot.com/guardrails/docs/reference/cli/installation#set-up-your-turbot-guardrails-credentials) using [Guardrails access keys](https://turbot.com/guardrails/docs/guides/iam/access-keys#generate-a-new-guardrails-api-access-key).

If you create a profile other than `default`, you can set an environment variable:

```sh
export TURBOT_PROFILE="my-workspace"
```

The profile will require the `Turbot/Admin` permission.

## Usage

Clone:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/aws/ec2/enforce_imdsv2_for_instances
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

### Enforce Mode

By default, the controls are set to Check mode based on the policy settings. To enable automated enforcements, you can switch to Enforce mode by changing the policy settings:

```hcl
resource "turbot_policy_setting" "aws_ec2_instance_metadata_service" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceMetadataService"
  value    =  "Enforce: Enabled for V2 only"
}
```

And re-applying the Terraform:

```sh
terraform plan
terraform apply
```

You can also change the policy value in the Guardrails console, though your Terraform state file may become out of sync.
