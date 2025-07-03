---
categories: ["cost controls", "storage", "security"]
primary_category: "cost controls"
type: "policy_pack"
---

# Enforce AWS EC2 Snapshots Active - Check if AMI Attached

This policy pack enforces that AWS EC2 snapshots are active, using a multi-query calculated policy. If a snapshot is referenced by any AMI (Amazon Machine Image), the policy is set to CHECK for safety; otherwise, it enforces deletion.

## Features
- Multi-query calculated policy for `AWS > EC2 > Snapshot > Active`:
  - If a snapshot is referenced by any AMI (via `BlockDeviceMappings[].Ebs.SnapshotId`), the policy returns `"Check: Active"` (snapshot is in use and not deleted).
  - If no AMIs reference the snapshot, the policy returns `"Enforce: Delete inactive with 30 days warning"` (safe to delete).
- Ensures only snapshots not in use by any AMI are targeted for cleanup.
- All logic is implemented as a calculated policy, visible in the Guardrails UI as part of the policy pack.

> **NOTE:**
> The `Enforce` action and warning period (currently set to 30 days) can be easily adjusted in the policy logic to meet your organization's requirements. Simply update the policy value in the calculated policy template as needed.

## Requirements
- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws-ec2](https://hub.guardrails.turbot.com/mods/aws/mods/aws-ec2)

## Usage

### Install Policy Pack

Clone:
```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/aws/ec2/enforce_snapshots_active_check_if_ami_attached
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

### Attaching the Policy Pack

By default, the policy pack is not attached to any resource. To test or use it:
- Add a `turbot_policy_pack_attachment` resource in `main.tf` for your target resource (e.g., AWS account).
- Apply the changes with Terraform.
- You can also attach the policy pack manually in the Guardrails UI for production.

### How the Policy Works
- The calculated policy uses two queries:
  1. Gets the current snapshot's ID.
  2. Searches for any AMIs referencing this snapshot ID in their `BlockDeviceMappings[].Ebs.SnapshotId`.
- If any AMIs reference the snapshot, it is considered active and not deleted (set to CHECK for safety).
- If no AMIs reference the snapshot, it is considered inactive and will be deleted with a 30-day warning.

By default, the calculated policy enforces deletion only when the snapshot is not in use. You can adjust the warning period in the policy logic if needed.

## Testing the Policy Pack Attachment

To test this policy pack on a specific resource (such as an AWS account, folder, or other supported resource), you can use the following Terraform block in your `main.tf`:

```hcl
# Uncomment and update the resource ID below to attach the policy pack for testing.
# This is useful for knowledge building, validation, or development.
# For production, it is recommended to attach the policy pack manually in the Guardrails UI.
#
# resource "turbot_policy_pack_attachment" "test" {
#   policy_pack = turbot_policy_pack.main.id
#   resource    = "<your_resource_id_here>"
# }
```

- Replace `<your_resource_id_here>` with the ID of the resource you want to test against.
- After testing, you can comment out or remove this block for production readiness.

## Support
For more information, see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs) and [Turbot Guardrails Provider authentication](https://registry.terraform.io/providers/turbot/turbot/latest/docs#authentication).