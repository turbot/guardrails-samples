# Testing Guide

This guide walks through a complete functional test of the quad-zero ingress
policy pack in a non-production AWS account. It creates four disposable
security groups that together exercise every behavior of the pack: detection
of IPv4 and IPv6 quad-zero rules, both exception levels, and the compliant
path. All steps are read-only for existing infrastructure; cleanup removes
everything the test creates.

## Prerequisites

- The policy pack is installed in your Guardrails workspace (`terraform apply`
  in this directory) and **attached** to the folder or account you will test
  in, with the template's default `Check: Approved` mode (Phase 1 — no
  changes are made to your resources).
- AWS CLI access to a sandbox/test account that is inside the attachment
  scope.
- A VPC in that account to hold the test security groups.

Set your context:

```sh
export AWS_PROFILE=<your-sandbox-profile>
export REGION=<region>            # e.g. us-east-1
export VPC_ID=<vpc-id>            # any VPC in the test account
```

## Step 1 — Create the test security groups

```sh
# 1. IPv4 quad-zero violation — expect Alarm
SG1=$(aws ec2 create-security-group --group-name quadzero-test-open-ipv4 \
  --description "Quad-zero test: expect Alarm (IPv4)" --vpc-id $VPC_ID --region $REGION \
  --query GroupId --output text)
aws ec2 authorize-security-group-ingress --group-id $SG1 \
  --protocol tcp --port 22 --cidr 0.0.0.0/0 --region $REGION

# 2. IPv6 quad-zero violation — expect Alarm
SG2=$(aws ec2 create-security-group --group-name quadzero-test-open-ipv6 \
  --description "Quad-zero test: expect Alarm (IPv6)" --vpc-id $VPC_ID --region $REGION \
  --query GroupId --output text)
aws ec2 authorize-security-group-ingress --group-id $SG2 --region $REGION \
  --ip-permissions 'IpProtocol=tcp,FromPort=443,ToPort=443,Ipv6Ranges=[{CidrIpv6=::/0}]'

# 3. Quad-zero violation WITH the exception tag — expect Skipped
SG3=$(aws ec2 create-security-group --group-name quadzero-test-excepted \
  --description "Quad-zero test: expect Skipped (exception tag)" --vpc-id $VPC_ID --region $REGION \
  --tag-specifications 'ResourceType=security-group,Tags=[{Key=quad-zero,Value=true}]' \
  --query GroupId --output text)
aws ec2 authorize-security-group-ingress --group-id $SG3 \
  --protocol all --cidr 0.0.0.0/0 --region $REGION

# 4. Compliant security group — expect OK
SG4=$(aws ec2 create-security-group --group-name quadzero-test-clean \
  --description "Quad-zero test: expect OK" --vpc-id $VPC_ID --region $REGION \
  --query GroupId --output text)
aws ec2 authorize-security-group-ingress --group-id $SG4 \
  --protocol tcp --port 443 --cidr 10.0.0.0/8 --region $REGION
```

> If the IPv6 rule is rejected because the VPC has no IPv6 CIDR block, either
> pick a VPC that has one or associate one:
> `aws ec2 associate-vpc-cidr-block --vpc-id $VPC_ID --amazon-provided-ipv6-cidr-block --region $REGION`

## Step 2 — Wait for discovery and evaluation

Guardrails discovers the new security groups through real-time events,
typically within one or two minutes. Each then gets an
`AWS > VPC > Security Group > Ingress Rules > Approved` control that
evaluates the calculated policy.

In the Guardrails console, go to **Controls** and filter:

- **Control Type**: `AWS > VPC > Security Group > Ingress Rules > Approved`
- **Resource**: your test account or VPC

## Step 3 — Verify the expected states

| Security group              | Configuration                                         | Expected state    | Expected reason        |
| --------------------------- | ----------------------------------------------------- | ----------------- | ---------------------- |
| `quadzero-test-open-ipv4` | SSH from`0.0.0.0/0`                                 | **Alarm**   | rule rejected by OCL   |
| `quadzero-test-open-ipv6` | HTTPS from`::/0`                                    | **Alarm**   | rule rejected by OCL   |
| `quadzero-test-excepted`  | all traffic from`0.0.0.0/0`, tag `quad-zero=true` | **Skipped** | "Approved set to skip" |
| `quadzero-test-clean`     | HTTPS from`10.0.0.0/8`                              | **OK**      | Approved               |

Also confirm there are no unexpected Alarms on your pre-existing security
groups: any Alarm raised should correspond to a genuine quad-zero ingress
rule.

To see the calculated policy decision for any security group, open the
security group resource in the console → **Policies** →
`Ingress Rules > Approved`: excepted groups show the computed value `Skip`,
all others `Check: Approved`.

## Step 4 — Dynamic exception flip

Exceptions take effect without any policy change or manual re-run. Tag one of
the alarming security groups from Step 3:

```sh
aws ec2 create-tags --resources $SG2 --tags Key=quad-zero,Value=true --region $REGION
```

Within a minute or two the tag change flows through the CMDB, the calculated
policy re-renders to `Skip`, and the control flips from **Alarm** to
**Skipped**. Remove the tag and the control returns to **Alarm**:

```sh
aws ec2 delete-tags --resources $SG2 --tags Key=quad-zero --region $REGION
```

This is the workflow account owners use during Phase 1 to except a genuine
use case they own.

## Step 5 — Account-level exception

The same tag on the **account** exempts every security group in it. The
calculated policy reads the tags on the Guardrails account resource
(`$.account.turbot.tags`), which are populated by whatever mechanism feeds
account tags into your workspace — typically a sync process that replicates
AWS Organizations account tags from your management account.

Apply `quad-zero=true` to the account through that mechanism and confirm the
tag appears on the Guardrails account resource. All
`Ingress Rules > Approved` controls in the account — including the Alarms
from Step 3 — then flip to **Skipped**. Remove the tag and they return to
their previous states.

## Step 6 (optional) — Phase 2 enforcement

> **Warning:** this step actively deletes non-compliant rules. Only run it in
> a sandbox.

Edit the calculated policy template in `policies.tf`, changing the
else-branch value from `"Check: Approved"` to `"Enforce: Delete unapproved"`,
then:

```sh
terraform apply
```

Expected results:

- The `0.0.0.0/0` / `::/0` ingress rules on `quadzero-test-open-ipv4` and
  `quadzero-test-open-ipv6` are revoked automatically (controls go from
  Alarm to OK once the rules are gone).
- `quadzero-test-excepted` keeps its open rule — exceptions are honored in
  enforcement mode too.
- `quadzero-test-clean` is untouched.

Return to check mode afterwards by reverting the template value to
`"Check: Approved"` and re-running `terraform apply`.

## Cleanup

```sh
for SG in $SG1 $SG2 $SG3 $SG4; do
  aws ec2 delete-security-group --group-id $SG --region $REGION
done
```

Guardrails removes the corresponding resources and controls automatically on
the delete events. Detach the policy pack (or leave it attached in check
mode) as appropriate for your rollout plan.
