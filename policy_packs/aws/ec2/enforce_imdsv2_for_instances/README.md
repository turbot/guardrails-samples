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

### Install

Clone:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/aws/ec2/enforce_imdsv2_for_instances
```

### Credentials

Installing this Policy Pack requires [admin credentials to a Turbot Guardrails workspace](https://turbot.com/guardrails/docs/guides/iam/access-keys) and [a way to run Terraform](https://turbot.com/guardrails/docs/7-minute-labs/terraform).

To setup your Guardrails credentials, please see [Set up your Guardrails credentials](https://turbot.com/guardrails/docs/7-minute-labs/cli#set-up-your-turbot-credentials).

## Usage

Run the Terraform to create the policy pack in your workspace:

```sh
terraform init
export TURBOT_PROFILE="my-workspace"
terraform plan
terraform apply
```

Attach the policy pack:

- Within the Guardrails UI navigate to [{workspace-url}/apollo?exploreMode=account](#).
- Select the account from the list for testing.
- Click on the "Detail" sub-tab and look for the "Policy Packs" widget in the bottom right of the page.
- Select the "MANAGE" link and `+ Add` the `Deny AWS EC2 Instances with Unapproved AMIs and/or Publisher Accounts` Policy Pack from the dropdown menu.
- Select "Save".

> [!IMPORTANT]
> Do not add or remove more than one Policy Pack to a resource at a time. Adding Policy Packs is an asynchronous operation, after changing the Policy Pack configuration for a resource, wait at least 5 minutes before adding or removing other Policy Packs.

### Verify state (OK, Alarm, Error) of associated controls (TODO: subject to change)

Within the Guardrails UI navigate to:

  ```sh
  {workspace-url}/apollo/controls/explore?filter=controlTypeId%3A%27tmod%3A%40turbot%2Faws-ec2%23%2Fcontrol%2Ftypes%2FinstanceApproved%27
  ```

  Replace `{workspace-url}` with the FQDN of your workspace (e.g. <https://company.cloud.turbot.com>). Use the "Resource" filter to select the test account where the Policy Pack is attached. Review all controls in `Alarm` state to understand why they are violating this policy pack objective.

### Resolve the alarms (TODO: subject to change)

For each control type, choose to [resolve the alarms](https://turbot.com/guardrails/docs/guides/quick-actions), [create resource exceptions](https://turbot.com/guardrails/docs/getting-started/activity-exceptions#manual-policy-exceptions) or to apply enforcement settings. The default setting for all controls are set to `Check: ...`. Each policy with an enforcement option will have a corresponding enforcement setting that is commented out. These can easily be found by searching across the `*.tf` files for `Enforce:`.

To apply enforcement automation: Open the Policy Pack Terraform source files in your code editor. Toggle between `Lockdown Disabled` and `Lockdown Enabled: Allow Image > ...` by changing which line is commented out:

  ```hcl
    resource "turbot_policy_setting" "aws_ec2_instance_deny_unapproved_ami_publisher" {
        resource = turbot_smart_folder.pack.id
        type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
        # value    = "Lockdown Disabled"
        # value    = "Lockdown Enabled: Allow Image > AMI IDs only"
        # value    = "Lockdown Enabled: Allow Image > Publishers only"
        # value    = "Lockdown Enabled: Allow Image > AMI IDs or Image > Publishers"
        value    = "Lockdown Enabled: Allow Image > AMI IDs from Image > Publishers"
    }
  ```

  Then re-apply the Terraform stack:

```sh
terraform plan
terraform apply
```

> [!CAUTION]
> Enforcement controls have the ability delete data, remove permissions and change configuration of your cloud resources. Guardrails automation is very fast and there is no undo; if you do not fully understand the scope of an enforcement or the potential impact to your applications then do not implement enforcement options.

