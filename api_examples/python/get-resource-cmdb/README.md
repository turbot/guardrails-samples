# Get Resource CMDB Data

Looks up a resource in Guardrails and returns the CMDB data. Supports two lookup modes and searches across multiple workspaces, stopping at the first match.

Useful for integrations (e.g. SolarWinds, ServiceNow) that need to pull resource configuration data from the Guardrails CMDB via the GraphQL API.

## Prerequisites

- [Python 3.\*.\*](https://www.python.org/downloads/)
- [Pip](https://pip.pypa.io/en/stable/installing/)

## Setup

### Virtual environment

```shell
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### Configuration

Copy the example config and edit it with your workspace details:

```shell
cp .config.example .config
```

The `.config` file defines which workspaces to search and how to authenticate to each one:

```yaml
workspaces:
  - name: aws-prod
    url: "https://aws-prod.cloud.turbot.com"
    auth: profile              # use Turbot CLI credentials (~/.config/turbot/credentials.yml)
    profile: aws-prod          # Turbot CLI profile name
    providers:
      - aws

  - name: azure-prod
    url: "https://azure-prod.cloud.turbot.com"
    auth: keys                 # inline credentials
    access_key: "your-access-key-here"
    secret_key: "your-secret-key-here"
    providers:
      - azure

  - name: multi-cloud
    url: "https://multi.cloud.turbot.com"
    auth: env                  # read from env vars
    access_key_var: MULTI_TURBOT_AK  # custom env var names (optional)
    secret_key_var: MULTI_TURBOT_SK
    providers:
      - aws
      - azure
      - gcp
```

**Auth types:**

| Type | Description |
| ---- | ----------- |
| `profile` | Uses a named profile from the [Turbot Guardrails CLI](https://turbot.com/guardrails/docs/reference/cli) credentials file (`~/.config/turbot/credentials.yml`). Set `profile` to the Turbot CLI profile name. **Note:** This refers to Turbot Guardrails CLI profiles, not AWS CLI profiles. See the [Turbot CLI installation and configuration guide](https://turbot.com/guardrails/docs/reference/cli/installation) for setup instructions. |
| `keys` | Inline Guardrails API access key and secret key. Set `access_key` and `secret_key` directly in the config. API keys can be generated from the Guardrails console under **Permissions > API Keys**. See [API access keys documentation](https://turbot.com/guardrails/docs/guides/iam/access-keys). |
| `env` | Reads credentials from environment variables. Defaults to `TURBOT_ACCESS_KEY_ID` and `TURBOT_SECRET_ACCESS_KEY`. Set `access_key_var` and `secret_key_var` to use custom variable names per workspace (useful with key vaults). |

**Providers:** `aws`, `azure`, `gcp`, `oci`. Used to skip workspaces that can't contain the requested resource. For example, an ARN lookup automatically skips workspaces that don't include `aws`.

## Usage

```shell
python3 get_resource_cmdb.py [OPTIONS]
```

### Lookup modes

| Mode | Description |
| ---- | ----------- |
| `--aka` | Direct lookup by AKA (e.g. ARN, Azure resource ID). Fast, single API call per workspace. |
| `--resource-id` + `--resource-type` | Filter-based lookup by cloud resource ID and Guardrails resource type URI. Use when you have the cloud ID but not the full AKA. |

The two modes are mutually exclusive.

### Options

| Option | Description |
| ------ | ----------- |
| `-a`, `--aka` | The AKA of the resource (e.g. AWS ARN, Azure resource ID). |
| `-r`, `--resource-id` | The cloud resource ID (e.g. `i-0abcd1234efgh5678`). Requires `--resource-type`. |
| `-t`, `--resource-type` | The Guardrails resource type URI (e.g. `tmod:@turbot/aws-ec2#/resource/types/instance`). |
| `-w`, `--workspace` | Search only this workspace (by name from config). |
| `-c`, `--config-file` | Path to config file. Default: `.config` in the script directory. |
| `--json-output` | Output raw JSON instead of formatted text. |

### Examples

#### Look up by ARN

```shell
python3 get_resource_cmdb.py \
  --aka "arn:aws:ec2:us-east-1:123456789012:instance/i-0abcd1234efgh5678"
```

#### Look up by resource ID and type

```shell
python3 get_resource_cmdb.py \
  --resource-id "i-0abcd1234efgh5678" \
  --resource-type "tmod:@turbot/aws-ec2#/resource/types/instance"
```

#### Search a specific workspace

```shell
python3 get_resource_cmdb.py \
  --workspace aws-prod \
  --aka "arn:aws:ec2:us-east-1:123456789012:instance/i-0abcd1234efgh5678"
```

#### Look up an Azure VM

```shell
python3 get_resource_cmdb.py \
  --aka "azure:///subscriptions/sub-id/resourceGroups/rg/providers/Microsoft.Compute/virtualMachines/my-vm"
```

#### Output raw JSON

```shell
python3 get_resource_cmdb.py \
  --aka "arn:aws:s3:::my-bucket" \
  --json-output
```

## Finding resource type URIs

Browse resource types and their AKA formats at [hub.guardrails.turbot.com](https://hub.guardrails.turbot.com). Each resource type page shows the URI to use with `--resource-type`.

Common examples:

| Resource | URI |
| -------- | --- |
| AWS EC2 Instance | `tmod:@turbot/aws-ec2#/resource/types/instance` |
| AWS S3 Bucket | `tmod:@turbot/aws-s3#/resource/types/bucket` |
| AWS IAM Role | `tmod:@turbot/aws-iam#/resource/types/role` |
| AWS Lambda Function | `tmod:@turbot/aws-lambda#/resource/types/function` |
| Azure Virtual Machine | `tmod:@turbot/azure-compute#/resource/types/virtualMachine` |
| Azure Storage Account | `tmod:@turbot/azure-storage#/resource/types/storageAccount` |
| GCP Compute Instance | `tmod:@turbot/gcp-computeengine#/resource/types/instance` |
