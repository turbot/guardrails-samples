# Policy Packs

Policy packs are collections of policy settings and make it easy to apply these policy settings to resources across the resource hierarchy. This directory contains multiple sample policy packs that can be used to implement common best practices for security, FinOps, compliance, and more.

## Documentation

**[Policy Packs →](https://hub.guardrails.turbot.com/policy-packs)**

## Getting Started

Each policy pack has installation and usage instructions, including requirements, credential setup, and more.

For more information, navigate to a policy pack in this directory or view all [policy packs on the Hub](https://hub.guardrails.turbot.com/policy-packs).

## Contributing

### Directory Structure

- Each policy pack is organized by its provider and service, e.g., `aws/ec2/enforce_imdsv2_for_instances`.
- If the policy settings use multiple services, then the primary service should be used.

#### Policy Pack Naming

Policy pack names should:

- Use the plural form of the resource type
- Do not include the provider or service since the folders above already contain them
- Begin with `check`, `deny`, `enable`, or `enforce`, depending on the control objective:
  - `check` is used for Policy Packs that do not have an enforcement option, e.g., check if AWS IAM root account has MFA enabled
  - `deny` is used for Policy Packs that take a preventative approach to solve the control objective, e.g., enable lockdown policies to deny launching AWS EC2 instances that use unapproved AMIs
  - `enable` is used for Policy Packs that enable a Guardrails feature or reporting through Guardrails, e.g., enable Guardrails event handling in an AWS account
  - `enforce` is used for Policy Packs that take a corrective approach to solve the control objective, e.g., stop or terminate AWS EC2 instances that use unapproved AMIs
- Be readable as short sentences
- Use snake case

#### Files

**main.tf**

This file includes a `turbot_policy_pack` resource with:
- `title` should be the same as the README header
- `description` should be a single sentence description of why the policy pack is helpful
- `akas` should be in the form of `<provider>_<service>_<policy pack name>`

**policies.tf**

This file contains policy settings that help achieve the control objective.

For each policy setting:
- Include a top comment with the full policy trunk
- For enum policy types, include a `Check` policy value as uncommented and other `Check`/`Enforce` policy values commented out
- For other policy types, include a comment mentioning valid values, e.g., `# Set between 1 and 64` for `AWS > EC2 > Instance > Metadata Service > HTTP Token Hop Limit`

**providers.tf**

This file contains the `provider` block for the [Turbot Guardrails Terraform Provider](https://registry.terraform.io/providers/turbot/turbot/latest/docs).

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
  - If there is a primary control with the policy pack, use that control's category
  - If there is no primary control, or its category is set to `Other`, then select a category
- `primary_category`
  - This should be one of the `categories` that best describes the control objective of the Policy Pack
- `type`
  - Set this to `featured` if you want it to appear on the Hub homepage

Other guidelines:

- The H1 header should be the control objective in title case and contain the provider and service names, as these appear on the Hub
- For the required mods, only include mods whose policy settings are included, not any 2nd or 3rd level mod dependencies
- Do not include the `Enable Enforcement` section if there is no `Enforce` policy value
