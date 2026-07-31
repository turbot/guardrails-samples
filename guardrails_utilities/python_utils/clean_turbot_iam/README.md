# Clean Turbot IAM Artifacts

Removes legacy Turbot IAM artifacts from every AWS account in a Guardrails workspace:

- Detaches and deletes these managed policies (if present):
  - `arn:<partition>:iam::<account>:policy/turbot_config_policy`
  - `arn:<partition>:iam::<account>:policy/turbot/turbot_lockdown`
  - `arn:<partition>:iam::<account>:policy/turbot/turbot_deny`
- Deletes the `turbot_config` role (if present), after detaching its managed
  policies, deleting its inline policies, and removing it from instance profiles.

The account list comes from the Guardrails GraphQL API. IAM changes are made
with the AWS CLI by assuming a role in each account, so valid AWS credentials
for the parent/hub account must be available in the environment (or via
`AWS_PROFILE`). The AWS partition (`aws` vs `aws-us-gov`) is detected
automatically from the caller identity.

By default the script assumes
`arn:aws:iam::<account>:role/vaec/turbot/core/c-vaec-turbot` with external id
`turbot` in region `us-east-1` (the commercial side defaults). Override with
`--role-name`, `--external-id`, and `--region` as needed.

## Prerequisites

- Python 3.8+ (dependencies are pinned to versions compatible with 3.8.10)
- [AWS CLI](https://aws.amazon.com/cli/) configured with credentials that can
  assume the target role in each account

## Setup

```bash
cd guardrails_utilities/python_utils/clean_turbot_iam
pip install -r requirements.txt
```

Turbot credentials follow the standard pattern: `TURBOT_ACCESS_KEY_ID`,
`TURBOT_SECRET_ACCESS_KEY` and `TURBOT_WORKSPACE` environment variables, a
profile in `~/.config/turbot/credentials.yml`, or a custom config file via
`--config-file`.

## Usage

Dry run (default, reports what would change without modifying anything):

```bash
python clean_turbot_iam.py
```

Apply changes:

```bash
python clean_turbot_iam.py --execute
```

Limit to specific accounts:

```bash
python clean_turbot_iam.py -a 123456789012 -a 210987654321 --execute
```

## Notes

- Policies also attached to users or groups are detached from those as well,
  since AWS requires full detachment before a policy can be deleted.
- If a target policy is in use as a permissions boundary, the script warns and
  skips it rather than removing the boundary.
- Accounts where the role assumption or any IAM call fails are reported at the
  end and the script exits non-zero.
