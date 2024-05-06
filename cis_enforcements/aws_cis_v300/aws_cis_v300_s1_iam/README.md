# AWS CIS v3.0.0 - Section 1 - IAM

### CIS Description
This section contains recommendations for configuring identity and access management 
related options.

### Turbot Guardrails Description
The Terraform stack in this section will create a Guardrails Smart Folder to manage all 
Guardrails policy settings used to create enforcement controls that are aligned to the
[CIS Amazon Web Services Foundations Benchmark](#).

## Installation

Prerequisites:
- Turbot Guardrails Workspace with 1 or more AWS accounts.
- Latest Turbot Guardrails `@turbot/aws-iam` mod installed.
- Ability to run Terraform v0.15 or higher (CLI or Cloud).

Clone:
```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/cis_enforcements/aws_cis_v300/aws_cis_v300_s1_iam
```

Install:
```sh
terraform init
terraform check
terrafrom apply
```

## Check Mode
The default setting for all enforcement controls in this section are set to `Check Mode`. Each policy setting that has an enforcement option will have a corresponding enforcement setting that is commented out. These can easily be found by searching in a given file for `Enforce:`.

## How to use

1. Create the smart folder (with check mode settings) in your workspace.
1. Attach the smart folder to your account(s)
    * Navigate to the AWS account in Guardrails.
    * Click on the `Detail` subtab.
    * On the right side of the screen select `MANAGE` in the `Smart Folders` section of the UI.
    * Click `+ Add` 
    * Select the current smart folder from the list.
      > NOTE: While you can have multiple smart folders attached to the same resource, you can only attach/detach one smart folder at a time.
    * Choose `Save`
1. Once applied, check that all applicable controls are in OK state.
1. If any controls are in Alarm, determine if having Guardrails enforce those controls would cause any disruption to the applications running in your account.
1. Once all alarms have been resolved or you have decided to allow Guardrails to enforce the controls, update the Terraform source from `Check` to `Enforce` see below.
1. After applying the changes, Guardrails will automatically enforce the policy settings preventing additional misconfiguration in the future.

To apply enforcements, comment out the `Check` setting and uncomment the 
`Enforce` setting:

```hcl
resource "turbot_policy_setting" "example" {
  resource = turbot_smart_folder.example.id
  type     = "tmod:@turbot/aws#/policy/types/resourceName"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}
```

for enforcement, change to:
```hcl
resource "turbot_policy_setting" "example" {
  resource = turbot_smart_folder.example.id
  type     = "tmod:@turbot/aws#/policy/types/resourceName"
  #value    = "Check: Approved"
  value    = "Enforce: Delete unapproved"
}
```

### Risks

Enforcement controls in this section have the possibility of removing IAM access for users and roles. Before using the enforcements in this section, make sure you have access to your IAM account through a role or user that will not be effected by the changes. Specific enforcements that can remove access:

`WARNING` Potential Enforcements:
- Deactivate existing access keys if they are too old.
- Detach IAM policies and IAM inline policies from IAM users.
- Remove login profiles (which will prevent login) from users without MFA.

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









