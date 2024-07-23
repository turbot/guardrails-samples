---
categories: ["logging", "networking"]
primary_category: "logging"
---

# Enable Global Event Handlers for AWS Accounts in Guardrails

The Guardrails Event Handlers are responsible for conveying events from AWS CloudTrail back to Guardrails for processing. This is a requirement for Guardrails to process and respond in real-time.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/policy-packs) can help you enable Global Event Handlers for AWS Accounts in Guardrails.

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_enable_global_event_handlers/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws](https://hub.guardrails.turbot.com/mods/aws/mods/aws)
  - [@turbot/aws-events](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws-events/mods/aws-events)
  - [@turbot/aws-sns](https://hub.guardrails.turbot.com/mods/aws/mods/aws-sns)
- IAM Role ARN used to forward events from the non-primary regions to the Primary Region. You can use [enable_iam_service_roles](../enable_iam_service_roles/) Policy Pack to create this IAM role

  - The below permissions are needed at minimum to allow the role to forward events to the Primary Region correctly:

    ```json
    {
      "Statement": [
        {
          "Action": ["events:PutEvents"],
          "Effect": "Allow",
          "Resource": "arn:<partition>:events:<region>:<accountId>:event-bus/default"
        }
      ],
      "Version": "2012-10-17"
    }
    ```

### Credentials

To create a policy pack through Terraform:

- Ensure you have `Turbot/Admin` permissions (or higher) in Guardrails
- [Create access keys](https://turbot.com/guardrails/docs/guides/iam/access-keys#generate-a-new-guardrails-api-access-key) in Guardrails

And then set your credentials:

```sh
export TURBOT_WORKSPACE=myworkspace.acme.com
export TURBOT_ACCESS_KEY=acce6ac5-access-key-here
export TURBOT_SECRET_KEY=a8af61ec-secret-key-here
```

Please see [Turbot Guardrails Provider authentication](https://registry.terraform.io/providers/turbot/turbot/latest/docs#authentication) for additional authentication methods.

## Usage

### Install Policy Pack

> [!NOTE]
> By default, installed policy packs are not attached to any resources.
>
> Policy packs must be attached to resources in order for their policy settings to take effect.

Clone:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/aws/guardrails/enable_global_event_handlers
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

### Apply Policy Pack

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/policy-packs#attach-a-policy-pack-to-a-resource).

If this policy pack is attached to a Guardrails folder, its policies will be applied to all accounts and resources in that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/resources/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

> [!IMPORTANT]
> Setting the policy in enforce mode will result in creation of resources in the target account. However, it is easy to remove those resources later, by setting the Stack's policy to `Enforce: Not configured`.

```hcl
resource "turbot_policy_setting" "aws_turbot_event_handlers_global" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/eventHandlersGlobal"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
