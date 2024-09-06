---
categories: ["cost controls"]
primary_category: "cost controls"
---

# Enable Turbot Notifications for AWS GovCloud Billing in Guardrails

The Guardrails Event Handlers are responsible for conveying events from AWS CloudTrail back to Guardrails for processing. This is a requirement for Guardrails to process and respond in real-time.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you enable [Turbot Notifications](https://turbot.com/guardrails/docs/guides/notifications) for AWS Accounts in Guardrails.

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_guardrails_enable_turbot_notifications_govcloud_billing/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws](https://hub.guardrails.turbot.com/mods/aws/mods/aws)
- [jq](https://jqlang.github.io/jq/)
- [Steampipe](https://steampipe.io/downloads)
- Steampipe Plugins:
  - [CSV](https://hub.steampipe.io/plugins/turbot/csv)
  - [Turbot Guardrails](https://hub.steampipe.io/plugins/turbot/guardrails)
- AWS Standard accounts to GovCloud accounts mapping.
  - Create a CSV file that maps Standard Cloud accounts to their corresponding GovCloud accounts using the format below. To help you get started, you can use Steampipe to generate this data. Run the following query against the **GovCloud Guardrails Workspace** connection:

    ```bash
    steampipe query "select 'TBD' as "standard_account_id", data ->> 'Id' as "govcloud_account_id", trunk_title as "govcloud_trunk_title", workspace as "govcloud_workspace", id as "govcloud_account_resource_id" from guardrails_resource where resource_type_uri  = 'tmod:@turbot/aws#/resource/types/account'" --output csv
    ```

  - The CSV format should look like this:

    | standard_account_id | govcloud_account_id | govcloud_trunk_title            | govcloud_workspace                  | govcloud_account_resource_id |
    |---------------------|---------------------|---------------------------------|-------------------------------------|------------------------------|
    | TBD                 | 222222222222        | Turbot > Montlake > deadshot    | https://console.govcloud.turbot.com | 331269922199500              |
    | TBD                 | 444444444444        | Turbot > waller > 444444444444  | https://console.govcloud.turbot.com | 330456246436869              |
    | TBD                 | 666666666666        | Turbot > 666666666666           | https://sandbox.govcloud.turbot.com | 180698850662056              |
    | TBD                 | 888888888888        | Turbot > devgov1 > 888888888888 | https://sandbox.govcloud.turbot.com | 325515057218706              |

  - Enable the `AWS > Account > Budget > Budget` control in the Guardrails workspaces of the standard accounts.
  - Run the following bash script for Standard Accounts Guardrails workspace.

    ```bash
    #!/bin/bash

    echo "Running the Steampipe query..."
    sp_query_output=$(steampipe query "SELECT 
      jsonb_agg(
        jsonb_build_object(
          'standard_account_id', metadata -> 'aws' ->> 'accountId',
          'govcloud_account_id', COALESCE(guest_accounts.govcloud_account_id::text, 'NA'),
          'govcloud_trunk_title', COALESCE(guest_accounts.govcloud_trunk_title::text, 'NA'),
          'govcloud_workspace', COALESCE(guest_accounts.govcloud_workspace::text, 'NA'),
          'govcloud_account_resource_id', COALESCE(guest_accounts.govcloud_account_resource_id::text, 'NA'),
          'budgetUpdatedSince', metadata ->> 'budgetUpdatedSince',
          'currentMonthActualSpend', data ->> 'currentMonthActualSpend',
          'currentMonthForecastSpend', data ->> 'currentMonthForecastSpend',
          'lastUpdatedTime', data ->> 'lastUpdatedTime',
          'lastAttemptTimestamp', metadata ->> 'lastAttemptTimestamp',
          'standard_trunk_title', trunk_title
        )
      ) AS budget_details
    FROM 
      guardrails_resource AS guardrails
    LEFT JOIN 
      (SELECT standard_account_id, govcloud_account_id, govcloud_trunk_title, govcloud_workspace, govcloud_account_resource_id FROM csv.aws_standard_govcloud_account_mappings) AS guest_accounts
    ON 
      guardrails.metadata -> 'aws' ->> 'accountId' = guest_accounts.standard_account_id
    WHERE 
      guardrails.resource_type_uri = 'tmod:@turbot/aws#/resource/types/budget';" --output json | jq -r '.rows[0]' )

    # putResource function
    put_resource() {
      echo "Updating the Turbot File resource..."
      turbot graphql --query 'mutation PutResource($input: PutResourceInput!) {
        putResource(input: $input) {
          metadata
          turbot {
            akas
            id
          }
        }
      }' --variables "{
        "input": {
          "id": "aws_standard_govcloud_budget",
          "metadata": {
            "title": \"AWS Standard GovCloud Budget File\",
            "description": \"AWS Standard GovCloud Budget File\"
          },
          "data": $sp_query_output
        }
      }"
    }

    # Check if the Turbot File resource exists
    echo "Checking if the Turbot File exists..."
    turbot graphql --query 'query checkForResource {
      resource(id: "aws_standard_govcloud_budget") {
        turbot {
          id
        }
      }
    }'

    # Check the exit status of the previous command
    if [[ $? -ne 0 ]]; then
      echo "Turbot File resource does not exist. Creating the resource..."

      # Create the resource
      turbot graphql --query 'mutation turbotFileCreation {
        createResource(
          input: {
            type: "tmod:@turbot/turbot#/resource/types/file",
            akas: ["aws_standard_govcloud_budget"],
            data: {},
            parent: "tmod:@turbot/turbot#/",
            metadata: {
              title: "AWS Standard GovCloud Budget File",
              description: "AWS Standard GovCloud Budget File"
            }
          }
        ) {
          turbot {
            id
          }
        }
      }'

      # Call the update function after creating the resource
      put_resource

    else
      echo "Resource exists."
      # Call the update function if the resource exists
      put_resource

    fi
    ```

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
>
> The `Turbot > Notifications` policy and its associated sub-policies are applied at the Turbot level. As a result, only two policy settings will be visible when viewing the policy pack.

Clone:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/aws/guardrails/enable_turbot_notifications_govcloud_billing
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

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/policy-packs#attach-a-policy-pack-to-a-resource).

If this policy pack is attached to a Guardrails folder, its policies will be applied to all accounts and resources in that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

> [!IMPORTANT]
> Setting the policy in enabled mode will result in notifications of resources in the target workspace. However, it is easy to stop the notifications later, by setting the policy to `Disabled`.

```hcl
resource "turbot_policy_setting" "turbot_notifications" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/notifications"
  value    = "Enabled"
  # value    = "Disabled"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
