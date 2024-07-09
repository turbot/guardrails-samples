# Policy Packs

Policy packs are self-contained modules that contain Terraform resources used to create Guardrails policy settings in a policy pack.

## Creating a Policy Pack

### Directory Structure

Each policy pack should be use the following directory structure: `<provider>/<service>/<pack name>`, e.g., `aws/ec2/enforce_imdsv2_for_instances`

If the policy settings use multiple services, then the primary service should be used

### Naming

Policy pack names should:
- Contain the resource in plural format
  - Do not include the provider or service since the folders above already contain them
- Begin with `deny`, `detect`, or `enforce`, depending on the control objective
- Be designed to be readable as short sentences
- Be in snake case

### Files

#### init.tf

This file includes:
- The `turbot` provider
- Policy pack resource
  - `title` should be the same as the README header
  - `description` should be the same as the README `description` in frontmatter
- Any service enabled policy setting resources

#### policies.tf

This file contains all non-service enabled policy settings

Other guidelines:
- Each policy setting should have a top comment with the full policy trunk
- For enum policy types, include a `Check` policy value as uncommented and other `Check`/`Enforce` policy values commented out
- For other policy types, include a comment mentioning valid values, e.g., `# Set between 1 and 64` for `AWS > EC2 > Instance > Metadata Service > HTTP Token Hop Limit`

#### README.md

Frontmatter should include:
- `categories`
  - All `categories` should be lowercase and only the last part of the title, e.g., `Resource > Encryption at Rest` would be `categories: ["encryption at rest"]`
  - Select control categories from the current [Guardrails control categories](https://turbot.com/guardrails/docs/mods/turbot/turbot/control-category)
    - If there is a primary control with the policy pack, use that control's category
    - If there is no primary control, or its category is set to `Other`, then select a category
- `description`
  - A one sentence description that explains why using the policy pack is helpful ("why" instead of "what")

Other guidelines:
- The H1 header should be the control objective in title case and contain the provider and service names
- For the required mods, only include mods whose policy settings are included, not any 2nd or 3rd level mod dependencies
- Do not include the `Enable Enforcement` section if there is no `Enforce` policy value
