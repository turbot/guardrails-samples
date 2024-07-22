# Policy Packs

Policy packs are self-contained modules that contain Terraform resources used to create Guardrails policy settings in a policy pack.

## Creating a Policy Pack

### Directory Structure

Each policy pack should use the following directory structure: `<provider>/<service>/<policy pack name>`, e.g., `aws/ec2/enforce_imdsv2_for_instances`

If the policy settings use multiple services, then the primary service should be used.

### Naming

Policy pack names should:

- Contain the resource in plural format
  - Do not include the provider or service since the folders above already contain them
- Begin with `check`, `deny`, or `enforce`, depending on the control objective
  - `check` is used for Policy Packs that do not have an enforcement option. E.g. check if AWS IAM root account has MFA enabled
  - `deny` is used for Policy Packs that take a preventative approach to solve the control objective. E.g. enable lockdown policies to deny launching AWS EC2 instances that use unapproved AMIs
  - `enforce` is used for Policy Packs that take a corrective approach to solve the control objective. E.g. Stop/Terminate AWS EC2 instances that use unapproved AMIs
- Be designed to be readable as short sentences
- Be in snake case

### Files

#### main.tf

This file includes:

- Policy pack resource
  - `title` should be the same as the README header
  - `description` should be the same as the README `description` in front matter
  - `akas` should be in the form of `<provider>_<service>_<policy pack name>`

#### policies.tf

- Each policy setting should have a top comment with the full policy trunk
- For enum policy types, include a `Check` policy value as uncommented and other `Check`/`Enforce` policy values commented out
- For other policy types, include a comment mentioning valid values, e.g., `# Set between 1 and 64` for `AWS > EC2 > Instance > Metadata Service > HTTP Token Hop Limit`

**Note**: If the policy pack needs to create policy settings across multiple services, individual files called `<service>.tf` should be created which would accommodate policy settings per service.

#### providers.tf

- The [Turbot Guardrails Terraform Provider](https://registry.terraform.io/providers/turbot/turbot/latest/docs)

#### README.md

Front matter should include:

- `categories`
  - All `categories` should be lowercase and from the below list:
    - access management
    - cis
    - compliance
    - compute
    - cost controls
    - data protection
    - logging
    - networking
    - security
    - storage
    - tagging
  - Select control categories from the current [Guardrails control categories](https://turbot.com/guardrails/docs/mods/turbot/turbot/control-category)
    - If there is a primary control with the policy pack, use that control's category
    - If there is no primary control, or its category is set to `Other`, then select a category
- `primary_category`
  - This should be one of the `categories` that best describes the control objective of the Policy Pack

Other guidelines:

- The H1 header should be the control objective in title case and contain the provider and service names
- For the required mods, only include mods whose policy settings are included, not any 2nd or 3rd level mod dependencies
- Do not include the `Enable Enforcement` section if there is no `Enforce` policy value
