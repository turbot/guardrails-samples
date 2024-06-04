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
