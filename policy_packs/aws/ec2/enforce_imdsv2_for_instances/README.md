---
category: ["public cloud"]
display_name: "Enforce IMDSv2 on AWS EC2 Instances"
short_name: "enforce_imdsv2_for_instances"
# TODO: Do we need a short description?
description: "Ensure that IMDSv2 is enforced for AWS EC2 instances."
# TODO: Do we need to list dependencies? Can they automatically be calculated?
mod_dependencies:
  - "@turbot/aws"
  - "@turbot/aws-iam"
  - "@turbot/aws-ec2"
---

# Enforce IMDSv2 on AWS EC2 Instances

Enforcing IMDSv2 on AWS EC2 instances enhances security by requiring session-based authentication to access instance metadata, mitigating the risk of unauthorized metadata exposure through vulnerabilities like SSRF (Server-Side Request Forgery). This helps ensure that only authorized applications and users can retrieve sensitive instance data.

## Documentation

- **[Policy settings →](/policy-packs/enforce_imdsv2_for_instances/settings)**

## Getting Started

### Requirements

The following mods need to be installed:

- `@turbot/aws`
- `@turbot/aws-iam`
- `@turbot/aws-ec2`

### Credentials

Installing this policy pack requires [admin credentials to a Turbot Guardrails workspace](https://turbot.com/guardrails/docs/guides/iam/access-keys) and [a way to run Terraform](https://turbot.com/guardrails/docs/7-minute-labs/terraform).

To setup your Guardrails credentials, please see [Set up your Guardrails credentials](https://turbot.com/guardrails/docs/7-minute-labs/cli#set-up-your-turbot-credentials).

## Usage

Clone:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/aws/ec2/enforce_imdsv2_for_instances
```

Run the Terraform to create the policy pack in your workspace:

```sh
export TURBOT_PROFILE="my-workspace"
terraform init
terraform plan
terraform apply
```

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/working-with-folders/smart#attach-a-smart-folder-to-a-resource).

> [!IMPORTANT]
> Do not add or remove more than one policy pack to a resource at a time. Adding policy packs is an asynchronous operation, after changing the policy pack configuration for a resource, wait at least 5 minutes before adding or removing other policy packs.
