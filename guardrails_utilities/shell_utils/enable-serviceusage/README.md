# Enable Service Usage API across an organization

Lists every project under a GCP organization and enables the Service Usage API
(`serviceusage.googleapis.com`) on each one.

Runs in **dry-run mode by default** — it only lists the projects and prints what
it _would_ do. Pass `--dry-run false` to actually enable the service.

## Prerequisites

To run the script, you must have:

- [Google Cloud CLI (`gcloud`)](https://cloud.google.com/sdk/docs/install)
- [jq](https://stedolan.github.io/jq/download/)
- An authenticated gcloud session: `gcloud auth login`
- IAM permission to list projects under the organization and to enable services
  on each project (`roles/serviceusage.serviceUsageAdmin` or equivalent, plus
  `roles/browser` / `resourcemanager.projects.list` at the org level).

## Executing the script

1. Ensure that you have execute privileges:

   ```shell
   chmod +x enable-serviceusage.sh
   ```

2. Authenticate and run:

   ```shell
   gcloud auth login
   ./enable-serviceusage.sh --org-id 123456789012
   ```

### Synopsis

```shell
./enable-serviceusage.sh --org-id <ORG_ID> [options]
```

### Options

--org-id (Required)

> [String] The numeric GCP organization ID whose projects will be processed.

--service (Optional)

> [String] The service to enable.
> Defaults to `serviceusage.googleapis.com`.

--dry-run (Optional)

> [String] When `false` the service is enabled on each project; when `true` the
> script only lists the projects and what it would do.
> Defaults to `true`.

--skip-system (Optional)

> [String] When `true` projects whose lifecycle state is not `ACTIVE` (e.g.
> `DELETE_REQUESTED`) are skipped.
> Defaults to `true`.

--help

> Lists all the options and their usages.

### Example usage

#### Example 1: List the projects that would be affected (dry-run)

```shell
./enable-serviceusage.sh --org-id 123456789012
```

#### Example 2: Enable the Service Usage API on every project

```shell
./enable-serviceusage.sh --org-id 123456789012 --dry-run false
```

#### Example 3: Enable a different service

```shell
./enable-serviceusage.sh --org-id 123456789012 --service compute.googleapis.com --dry-run false
```

## Notes

- A `parent.id` filter on `gcloud projects list` returns projects whose **direct
  parent** is the organization. Projects nested inside **folders** are not
  returned. For a fully org-wide sweep including folder-nested projects, use
  [`gcloud asset search-all-resources`](https://cloud.google.com/sdk/gcloud/reference/asset/search-all-resources)
  with `--scope=organizations/<ORG_ID>` and adapt the loop. The script warns when
  the direct-parent query returns nothing.
- Enabling a service is idempotent — re-running on a project that already has the
  API enabled is a no-op.
