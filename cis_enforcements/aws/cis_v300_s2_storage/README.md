---
benchmark: AWS CIS v3.0.0
section_number: 2
section_name: Storage
cis_description: "This section contains recommendations for configuring AWS Storage."
icon: "aws.svg"
mod_dependencies:
  - "@turbot/aws"
  - "@turbot/aws-ec2"
  - "@turbot/aws-s3"
  - "@turbot/aws-rds"
  - "@turbot/aws-efs"
---

# Enforce AWS CIS v3.0.0 - Section 2 - Storage

Automate enforcement of CIS benchmark best practices using Turbot Guardrails.

The Terraform stack defined in this section will create a Guardrails Smart Folder, containing specific policy examples, to automate enforcement controls aligned to the [CIS Amazon Web Services Foundations Benchmark](#).

## Installation

Installing this Smart Folder requires [admin credentials to a Turbot Guardrails workspace](#), the [`@turbot/aws-cisv3-0`](#) mod (with all of it's dependencies) installed and [a way to run Terraform](#).

Clone the repo locally:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/cis_enforcements/aws_cis_v300/aws_cis_v300_s2_storage
```

## How to use

1. __Create the Smart Folder in your workspace__:

    ```sh
    terraform init
    export TURBOT_PROFILE="my-workspace"
    terraform plan 
    terrafrom apply
    ```

1. __Attach the Smart Folder to your test account__: Within the Guardrails UI navigate to [{workspace-url}/apollo?exploreMode=account](#). Select the account from the list for testing. Click on the "Detail" subtab and look for the "Smart Folders" widget in the bottom right of the page. Select the "MANAGE" link and `+ Add` the `AWS CIS v3.0.0 - Section 2 - Storage` Smart Folder from the dropdown menu, then select "Save".
    > [!IMPORTANT]
    > Do not add or remove more than one Smart Folder to a resource at a time.  Adding Smart Folders is an asyncronous operation, after changing the Smart Folder configuration for a resource, wait at least 5 minutes before adding or removing other Smart Folders.

1. __Verify state (`OK`, `Alarm`, `Error`) of associated controls__: Within the Guardrails UI navigate to [{workspace-url}/apollo/reports/controls-by-resource?filter=state%3Aalarm+controlTypeId%3A%27tmod%3A%40turbot%2Faws-s3%23%2Fresource%2Ftypes%2Fs3%27%2C%27tmod%3A%40turbot%2Faws-ec2%23%2Fresource%2Ftypes%2Fec2%27%2C%27tmod%3A%40turbot%2Faws-rds%23%2Fresource%2Ftypes%2Frds%27%2C%27tmod%3A%40turbot%2Faws-efs%23%2Fresource%2Ftypes%2Fefs%27](#). Use the "Resource" filter to select the test account where the Smart Folder is attached. Review all controls in `Alarm` state to understand why they are violating CIS control objectives.
1. For each control type, choose to [resolve the alarms](#), [create resource exceptions](#) or to apply enforcement settings. The default setting for all controls are set to `Check: ...`. Each policy with an enforcement option will have a corresponding enforcement setting that is commented out. These can easily be found by searching across the `*.tf` files for `Enforce:`.
1. To apply enforcement automation: Open the Smart Folder Terraform source files in your code editor. Toggle individual controls between `Check` and `Enforce` by changing which line is commented out:

    ```hcl
    resource "turbot_policy_setting" "example" {
      resource = turbot_smart_folder.example.id
      type     = "tmod:@turbot/aws#/policy/types/resourceName"
      # value    = "Check: Approved"
      value    = "Enforce: Delete unapproved"
    }
    ```

    Then re-apply the Terraform stack:

    ```sh
    terraform plan 
    terrafrom apply
    ```

    > [!CAUTION]
    > Enforcement controls have the ability delete data, remove permissions and change configuration of your cloud resources. Guardrails automation is very fast and there is no undo; if you do not fully understand the scope of an enforcement or the potential impact to your applications then do not implement enforcement options.
