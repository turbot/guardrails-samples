# Guidelines to build a Policy Pack

## Folder

- Top level folder should be of the cloud provider. e.g. aws
- Policy packs should be group per service. e.g. aws/ec2
- Policy pack name should be in a regular sentence format that is easily readable. e.g. detect_unapproved_ami_publisher_for_instance
- Use snake_case

## Files

### common.tf

This file includes:

#### a. A policy pack Terraform resource

e.g.

```hcl
# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Deny AWS EC2 instances with unapproved AMIs and/or publisher accounts"
  description = "Deny launch of EC2 instances that do not approved AMIs and Publisher Accounts"
  parent      = "tmod:@turbot/turbot#/"
}
```

- Resource name should `pack`. This will allow users to build composite packs i.e. combining multiple policy packs into one. Having `pack` as the policy pack name across policy packs will allow users to form composite packs easily.
- Title should clearly define what the policy pack does.
- Description should be a short summary of what the policy pack does. (Ask ChatGPT).

#### b. Terraform to enable relevant services for the policy pack

```hcl
# AWS > EC2 > Enabled
resource "turbot_policy_setting" "aws_ec2_enabled" {
  resource = turbot_smart_folder.aws_ec2_instance_deny_unapproved_ami_publisher.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2Enabled"
  value    = "Enabled"
}
```

- Include a comment which says which service to enable.
- Comment should start with capital letters and not have a period at the end
- Resource name should be `<provider>_<service>_enabled`

### main.tf

- This file includes a way to initialize the Guardrails Terraform provider.
- This will mostly be the same across policy packs.

```hcl
terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
}
```

### policies.tf

- This file includes:
- All relevant policy settings for the resource per the policy pack.
- Resource names for all the policy settings should be in the form of `"<provider>_<service>_<policy_setting_name>"`. E.g. `aws_ec2_instance_approved`, `aws_ec2_instance_approved_image`, `aws_ec2_instance_approved_image_ami_ids`. This will allow users to form composite policy packs and main uniqueness across resource names.

### README.md

- Follow `policy_pack_example_readme.md` and file for details and `detect_unapproved_ami_publisher_for_instance.md` as an example.

# FAQ

## General

Q. `Policy Pack` or `Policy-Pack` or `Policy Pack` or `policy-pack` or `Policy Pack`?
Nathan - it's a type / pronoun similar to "Smart Folder" or "Resource Type", etc ... so it's "Policy Pack".

## Directory structure

Q. What does the directory structure look like?

├── policy_packs
│   ├── aws_account_import
│   ├── aws_audit_logging
│   ├── aws_baseline
│   ├── aws_check_cost_controls
│   ├── aws_check_encryption
│   ├── aws_check_iam
│   ├── aws_check_logging
│   ├── aws_check_public_access
│   ├── aws_check_regions
│   ├── aws_check_s3
│   ├── azure_check_encryption
│   ├── azure_check_logging
│   ├── azure_check_public_access
│   ├── gcp_check_encryption
│   ├── gcp_check_iam
│   ├── gcp_check_labeling
│   ├── gcp_check_logging
│   ├── turbot_iam_roles
│   ├── turbot_logging_buckets
│   └── turbot_profiles

Q. How are the directories named?
A. Directories for Policy Packs are named as per the problem they solve. Should be of the format `<provider>_<service>_<problem_it_solves>`. E.g. `aws_vpc_flow_logs_s3_bucket`.

Q. How are the files named?

Q. How do we decide how many files should we have under a directory? (E.g. For CIS enforcements, do we have 1 file for related policies which makes 5 controls green, or do we separate them out in 5 different files?)

Q. What are the standard files under a Policy Pack directory?
A. Each Policy Pack definition will contain a main.tf, common.tf, and README.MD.

├── aws_cis_v300_s1_iam
    ├── README.md            -> Standard README
    ├── common.tf            -> Policy Pack (SF) + service enabled settings
    ├── main.tf              -> Provider & Var Definitions
    └── policy_pack.tf       -> Policy Types and/or Stack settings

## File content

Q. How are the Policy Settings defined?
A. Policies should be preceded with a comment corresponding to the Guardrails policy trunk title.

- Policy Pack (SF) IDs should match the folder name e.g. `aws_cis_v300_s1_iam`
- Use `terraform fmt` to adhere to the standard HCL style guide.
- Order of fields:
    1. resource
    2. type
    3. note
    4. value (if needed)
    5. template_input (if needed)
    6. template (if needed)
- Notes should contain a short reference to the CIS control(s) they are associated with. e.g.: `"AWS CIS v3.0.0 - Controls: 1.10 & 1.11"`
- multi-line strings should use the [indented heredoc](https://developer.hashicorp.com/terraform/language/expressions/strings#indented-heredocs) `<<-EOT` style.

Q. Enforcement options for standard policies in a Policy Pack?

- All policies should be set initially to "Check: ..."
- Add additional lines into the configuration representing any appropriate "Enforce: ..." options.
- Comment out the "Enforce: ..." options using the code editor's auto comment function (Cmd-/ in VS Code).  This adds `#` in front of the first non-whitespace char in the line.  In this way when uncommented, the HCL will still align properly.

Q. Enforcement options for calculated policies in a Policy Pack?

- All calc policies should be set initially to "Check: ..."
- Add hardcoded values for check and enforce options into the template input and comment out the enforcement option. e.g.:

    ```hcl
    value: constant(value: "Check: Login profile enabled")
    # value: constant(value: "Enforce: Delete login profile")
    ```

- Use `$.value` in the calc policy template where you would normally hardcode the policy value output. e.g.:

    ```nunjucks
    {%- if (not has_mfa) or has_key -%}
    {{ $.value | json }}
    {%- else -%}
    ```

Q. When should we include variables for a Policy Pack?
A. Avoid the use of variables unless the same value would need to be repeated in multiple parts of a template.

Q. Does every Policy Pack have a README.md?
A. Yes. Every Policy Pack should have a README.md file to clearly indicate the steps to install the Policy Pack and describe what problem it solves.

Q. What are the standard sections for a README file?

Q. Should the tfvars file always be called `default.tfvars.example`?

## README content

<!-- # README template below-->

# Title <!-- Title of the Policy Pack. What problem is it solving?-->

Description <!-- Describe what the Policy Pack does (what it installs/creates) and what it solves.-->

## Installation <!-- Installation steps for the Policy Pack. Clear step-by-step instructions-->

Prerequisites
Steps

## How to use <!-- Instructions on how to use the Policy Pack. Clear step-by-step instructions -->

Step headers should be in bold.
Links should be double checked if they render correctly, and work as expected.
