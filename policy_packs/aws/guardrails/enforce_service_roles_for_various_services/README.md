---
categories: ["access management", "security"]
primary_category: "access management"
type: "featured"
---

# Enforce Service Role for Various Services

Enforcing the use of service roles for various services is crucial to maintain a secure and least-privileged access model within AWS. This control ensures that each service and application operates with only the permissions it needs to perform its specific tasks, thereby minimizing the risk of unauthorized access and potential security breaches caused by over-permissioned accounts.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/smart-folders) can help you configure the following settings for following services:

- Create all respective service roles that are enabled
- Enable service role for configuration recording
- Enable service role for default EC2 instance
- Enable service role for flow logging
- Enable service role for SSM notification
- Enable service role for global event handler

## Documentation

- **[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/enforce_service_roles_for_various_services/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Guardrails mods:
  - [@turbot/aws](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws)

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
cd guardrails-samples/policy_packs/aws/guardrails/enforce_service_roles_for_various_services
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

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/working-with-folders/smart#attach-a-smart-folder-to-a-resource).

If this policy pack is attached to a Guardrails folder, its policies will be applied to all accounts and resources in that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/resources/smart-folders).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "aws_turbot_service_roles_configured" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRoles"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
