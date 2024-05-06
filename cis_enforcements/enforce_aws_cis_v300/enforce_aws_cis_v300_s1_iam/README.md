---
benchmark: AWS CIS v3.0.0
section_number: 1
section_name: IAM
cis_description: "This section contains recommendations for configuring identity and access management related options."
icon: "aws.svg"
mod_dependencies:
  - "@turbot/aws"
  - "@turbot/aws-iam"
---

# Enforce AWS CIS v3.0.0 - Section 1 - IAM

Automate enforcement of CIS benchmark best practices using Turbot Guardrails.

The Terraform stack defined in this section will create a Guardrails Smart Folder, containing specific policy examples, to automate enforcement controls aligned to the [CIS Amazon Web Services Foundations Benchmark](#).

## Installation

Verify Prerequisites:
- Turbot CLI
    ```sh
    $ turbot --version
    1.28.6
    ```
- Turbot Guardrails Workspace:
    ```sh
    $ turbot graphql --query '{policyValues(filter: "policyTypeId:tmod:@turbot/turbot#/policy/types/workspaceVersion,tmod:@turbot/turbot#/policy/types/workspaceUrl level:self") {items {value type {title}}}}' --profile my-workspace-profile
    policyValues:
      items:
        - value: 'https://demo-turbot.cloud.turbot-dev.com/apollo'
          type:
            title: Workspace URL
        - value: 5.42.23
          type:
            title: Workspace Version
    ```

- Ensure required mods are installed
    ```sh
    $ turbot graphql --query '{resources(filter:"resourceTypeId:tmod:@turbot/turbot#/resource/types/mod level:self limit:200 @turbot/aws") {items{title}}}' --profile my-workspace-profile
    resources:
      items:
        - title: '@turbot/aws'
        - ...
    ```
- Terraform CLI
    ```sh
    $ terraform -v       
    Terraform v1.7.4
    ```

Clone the repo locally:
```sh
$ git clone https://github.com/turbot/guardrails-samples.git
$ cd guardrails-samples/cis_enforcements/aws_cis_v300/aws_cis_v300_s1_iam
```

Install the Smart Folder into your workspace with Terraform:
```sh
$ terraform init
$ terraform plan
$ terrafrom apply
```

> [!CAUTION]
> The default setting for all enforcement controls in this section are set to `Check Mode`. Each policy setting that has an enforcement option will have a corresponding enforcement setting that is commented out. These can easily be found by searching in a given file for `Enforce:`.
>
> Once changed, the enforcement controls in this section have the possibility of removing IAM access for users and roles. Before using the enforcements in this section, make sure you have access to your IAM account through a role or user that will not be effected by the changes. Specific types of enforcements in this section that can remove access:
>   - Deactivate existing access keys if they are too old.
>   - Detach IAM policies and IAM inline policies from IAM users.
>   - Remove login profiles (which will prevent login) from users without MFA.

## How to use

1. Create the Smart Folder in your workspace.
1. Attach the Smart Folder to your account(s).
1. Verify state (`OK`, `Alarm`, `Error`) of associated controls.
1. Choose to [resolve alarms](#), [create exceptions](#) or to apply enforcement settings:

Toggle between `Check` and `Enforce` by changing which line is commented out:

```hcl
resource "turbot_policy_setting" "example" {
  resource = turbot_smart_folder.example.id
  type     = "tmod:@turbot/aws#/policy/types/resourceName"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved"
}
```

## Credentials
By default, Terraform will prompt you for the Guardrails profile to be used to authenticate.
Guardrails profiles can be created by [installing the Turbot Guardrails CLI](https://turbot.com/guardrails/docs/7-minute-labs/cli) and running the configure command:

```sh
$ turbot configure
✔ Profile name [default] … default
✔ Workspace URL … https://turbot-customer.cloud.turbot.com
✔ Turbot Access Key … ************************************
✔ Turbot Secret Key … ************************************
Written profile 'default' to '/Users/TestUser/.config/turbot/credentials.yml'
```

Additional authentication types are available and [documented as part of the Turbot Guardrails provider](https://registry.terraform.io/providers/turbot/turbot/latest/docs).