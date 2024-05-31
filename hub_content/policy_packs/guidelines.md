# Guidelines to build a Policy Pack

## Folder

- starts with the provider name
- add the resource type name after provider name
- add what the policy pack does, starting with a verb
- use snake_case
- e.g. aws_ec2_instance_deny_unapproved_ami

## Files

### common.tf

This file includes:

#### a. A policy pack TF resource

e.g.

```hcl
# Policy Pack
resource "turbot_smart_folder" "aws_ec2_instance_deny_unapproved_ami" {
  title       = "AWS EC2 instance deny unapproved AMIs"
  description = "Deny the launch of EC2 instances that are not using approved AMIs"
  parent      = "tmod:@turbot/turbot#/"
}
```

- resource name should be same as <folder_name>.
- title should clearly define what the policy pack does.
- description should be a short summary of what the policy pack does. (Ask ChatGPT).

#### b. TF to enable relevant services for the policy pack

```hcl
# AWS > EC2 > Enabled
resource "turbot_policy_setting" "aws_ec2_enabled" {
  resource = turbot_smart_folder.aws_ec2_instance_deny_unapproved_ami.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2Enabled"
  value    = "Enabled"
}
```

- Include a comment which says which service to enable.
- Comment should start with capital letters and not have a period at the end
- resource name should be <provider>_<service>_enabled

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

### <folder_name>.tf

- This file includes:
- All relevant policy settings for the resource per the policy pack.

### README.md

- Follow `policy_pack_example_readme.md` and file for details and `aws_ec2_instance_deny_unapproved_ami.md` as an example.
