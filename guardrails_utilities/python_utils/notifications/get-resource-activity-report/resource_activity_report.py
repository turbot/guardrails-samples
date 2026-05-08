#!/usr/bin/env python3
"""
Guardrails Resource Activity Report

Pulls resource create/delete/update activity by a specific actor (e.g. Turbot
automation identity) from one or more Guardrails workspaces. Outputs CSV
matching the console Resource Activities report format.

Designed for cases where the console Resource Activities report times out on
large notification datasets. The script fetches only resource-level CRUD
notifications (not control/policy processing), making it fast even on
workspaces with millions of notifications.

Authentication uses ~/.config/turbot/credentials.yml (same as Turbot CLI).
"""

import argparse
import csv
import os
import sys
import time
from base64 import b64encode
from datetime import datetime, timedelta, timezone

import requests
import yaml

CREDENTIALS_PATH = os.path.expanduser("~/.config/turbot/credentials.yml")
GRAPHQL_PATH = "api/v5/graphql"
# 100 is the largest filter `limit:` value that still returns a working
# paging cursor on Guardrails. Values ≥500 hit a server-side cap (~255 items)
# AND null the cursor, killing pagination. Don't raise without re-validating.
PAGE_SIZE = 100
DEFAULT_TIMEOUT = 300
PROBE_TIMEOUT = 30

# Short aliases for common AWS resource types. Users can also pass full
# `tmod:@turbot/...` URIs directly.
RESOURCE_TYPE_ALIASES = {
    "snapshot": "tmod:@turbot/aws-ec2#/resource/types/snapshot",
    "ec2-snapshot": "tmod:@turbot/aws-ec2#/resource/types/snapshot",
    "instance": "tmod:@turbot/aws-ec2#/resource/types/instance",
    "ec2-instance": "tmod:@turbot/aws-ec2#/resource/types/instance",
    "volume": "tmod:@turbot/aws-ec2#/resource/types/volume",
    "ami": "tmod:@turbot/aws-ec2#/resource/types/image",
    "vpc": "tmod:@turbot/aws-vpc-core#/resource/types/vpc",
    "security-group": "tmod:@turbot/aws-vpc-security#/resource/types/securityGroup",
    "bucket": "tmod:@turbot/aws-s3#/resource/types/bucket",
    "s3-bucket": "tmod:@turbot/aws-s3#/resource/types/bucket",
    "role": "tmod:@turbot/aws-iam#/resource/types/role",
    "iam-role": "tmod:@turbot/aws-iam#/resource/types/role",
    "user": "tmod:@turbot/aws-iam#/resource/types/user",
    "iam-user": "tmod:@turbot/aws-iam#/resource/types/user",
    "iam-policy": "tmod:@turbot/aws-iam#/resource/types/policy",
    "lambda": "tmod:@turbot/aws-lambda#/resource/types/function",
    "rds-instance": "tmod:@turbot/aws-rds#/resource/types/dbInstance",
    "rds-cluster": "tmod:@turbot/aws-rds#/resource/types/dbCluster",
    "rds-snapshot": "tmod:@turbot/aws-rds#/resource/types/dbSnapshot",
    "kms-key": "tmod:@turbot/aws-kms#/resource/types/key",
}


def resolve_resource_types(values):
    """Expand --resource-type values: alias or full URI; commas split a value."""
    resolved = []
    for v in values:
        for token in v.split(","):
            token = token.strip()
            if not token:
                continue
            resolved.append(RESOURCE_TYPE_ALIASES.get(token, token))
    return resolved

NOTIFICATIONS_QUERY = """
query ResourceActivity($filter: [String!], $paging: String, $dataSource: NotificationDataSource) {
  notifications(filter: $filter, paging: $paging, dataSource: $dataSource) {
    items {
      turbot {
        id
        createTimestamp
      }
      notificationType
      resource {
        type {
          title
          category {
            title
          }
        }
        trunk {
          title
        }
        turbot {
          id
          title
        }
      }
      actor {
        identity {
          trunk {
            title
          }
          turbot {
            id
            title
          }
        }
      }
    }
    paging {
      next
    }
  }
}
"""

TURBOT_IDENTITY_QUERY = """
query FindTurbotIdentity($filter: [String!]) {
  resources(filter: $filter) {
    items {
      turbot {
        id
        title
      }
    }
  }
}
"""

COUNT_QUERY = """
query CountActivity($filter: [String!]) {
  notifications(filter: $filter) {
    metadata { stats { total } }
  }
}
"""


def load_profile(profile_name):
    """Load workspace credentials from ~/.config/turbot/credentials.yml."""
    if not os.path.exists(CREDENTIALS_PATH):
        print(f"Error: Credentials file not found at {CREDENTIALS_PATH}")
        print(
            "Create it with your workspace profiles. See: "
            "https://turbot.com/guardrails/docs/reference/cli/installation"
            "#set-up-your-turbot-guardrails-credentials"
        )
        sys.exit(1)

    with open(CREDENTIALS_PATH, "r") as f:
        creds = yaml.safe_load(f)

    if profile_name not in creds:
        available = ", ".join(creds.keys())
        print(f"Error: Profile '{profile_name}' not found. Available: {available}")
        sys.exit(1)

    profile = creds[profile_name]
    for key in ("workspace", "accessKey", "secretKey"):
        if key not in profile:
            print(f"Error: Profile '{profile_name}' missing '{key}'")
            sys.exit(1)

    workspace = profile["workspace"].rstrip("/")
    auth_bytes = f"{profile['accessKey']}:{profile['secretKey']}".encode("utf-8")
    auth_token = b64encode(auth_bytes).decode()

    return workspace, {
        "endpoint": f"{workspace}/{GRAPHQL_PATH}",
        "headers": {
            "Authorization": f"Basic {auth_token}",
            "Content-Type": "application/json",
        },
    }


def graphql_request(config, query, variables=None, timeout=DEFAULT_TIMEOUT):
    """Execute a GraphQL query against the workspace."""
    payload = {"query": query}
    if variables:
        payload["variables"] = variables

    response = requests.post(
        config["endpoint"],
        json=payload,
        headers=config["headers"],
        timeout=timeout,
    )
    response.raise_for_status()
    result = response.json()

    if "errors" in result:
        for err in result["errors"]:
            msg = str(err.get("message", "unknown error"))
            print(f"  GraphQL error: {msg}")

    return result


def get_turbot_identity_id(config):
    """Auto-detect the Turbot Identity actor ID in the workspace."""
    result = graphql_request(
        config,
        TURBOT_IDENTITY_QUERY,
        {
            "filter": [
                "resourceTypeId:'tmod:@turbot/turbot-iam#/resource/types/turbotIdentity'",
                "limit:1",
            ]
        },
    )
    items = (result.get("data") or {}).get("resources", {}).get("items", [])
    if items:
        return items[0]["turbot"]["id"]
    return None


DEFAULT_NOTIFICATION_TYPES = ("resource_created", "resource_deleted", "resource_updated")


def build_base_filter(resource_type_id, actor_id, since_date=None, until_date=None, notification_types=None):
    """Build the filter string matching the console's report shape.

    - `resourceTypeId:` (not `resourceType:`) is the indexed field name.
    - Numeric `actorIdentityId:` is unquoted (URI-style values still use quotes).
    - Timestamps must be `YYYY-MM-DD` (date-only); the parser rejects full ISO8601.
    - No `sort:` clause — server's default compound sort `(-id, -timestamp)` is
      what makes cursor pagination stable across mass-delete bursts.
    """
    ntypes = notification_types or DEFAULT_NOTIFICATION_TYPES
    parts = [
        f"resourceTypeId:'{resource_type_id}'",
        f"actorIdentityId:{actor_id}",
        f"notificationType:{','.join(ntypes)}",
    ]
    if since_date:
        parts.append(f"timestamp:>{since_date}")
    if until_date:
        parts.append(f"timestamp:<{until_date}")
    return " ".join(parts)


def count_window(config, base_filter, timeout=PROBE_TIMEOUT):
    """Return the stats total for `base_filter`, or None on failure."""
    try:
        result = graphql_request(config, COUNT_QUERY, {"filter": base_filter}, timeout=timeout)
        meta = ((result.get("data") or {}).get("notifications") or {}).get("metadata") or {}
        return (meta.get("stats") or {}).get("total")
    except Exception as e:
        print(f"    Count query failed: {e}")
        return None


def fetch_window(config, base_filter, page_size=PAGE_SIZE, data_source=None):
    """Paginate one window's results.

    `base_filter` is the per-window filter string; `limit:` is appended as a
    separate filter array element to match the console's variable shape.
    """
    filter_array = [base_filter, f"limit:{page_size}"]
    all_items = []
    next_page = None
    page_num = 0

    while True:
        page_num += 1
        variables = {"filter": filter_array, "paging": next_page}
        if data_source:
            variables["dataSource"] = data_source

        max_retries = 3
        for attempt in range(1, max_retries + 1):
            try:
                result = graphql_request(config, NOTIFICATIONS_QUERY, variables)
                break
            except requests.exceptions.Timeout:
                if attempt < max_retries:
                    wait = attempt * 15
                    print(f"    Page {page_num}: timeout (attempt {attempt}/{max_retries}) — retrying in {wait}s...")
                    time.sleep(wait)
                else:
                    print(f"    Page {page_num}: timeout after {max_retries} attempts — stopping window")
                    return all_items, False

        data = result.get("data") or {}
        notifications = data.get("notifications") or {}
        items = notifications.get("items") or []
        all_items.extend(items)

        paging = notifications.get("paging") or {}
        if page_num == 1 or page_num % 10 == 0 or not paging.get("next"):
            print(f"    Page {page_num}: {len(items)} items (total so far: {len(all_items)})")

        if paging and paging.get("next"):
            next_page = paging["next"]
        else:
            break

    return all_items, True


def build_windows(days, from_date=None, to_date=None):
    """Return [(since_date, until_date, label), ...] one entry per UTC day.

    Each window covers a full UTC day, expressed as YYYY-MM-DD strings
    suitable for the `timestamp:>since timestamp:<until` filter syntax.

    Without --from/--to, the convention is "the last N completed UTC days":
    end = today's UTC midnight (start of today), start = end - N days. This
    matches a daily-audit-ingest pattern where today's partial data is
    deferred to tomorrow's run.
    """
    if from_date and to_date:
        start = _parse_date(from_date)
        end = _parse_date(to_date)
    else:
        today_midnight = datetime.now(timezone.utc).replace(
            hour=0, minute=0, second=0, microsecond=0
        )
        end = today_midnight
        start = end - timedelta(days=days)

    if start >= end:
        return []

    windows = []
    cursor = start
    while cursor < end:
        win_end = cursor + timedelta(days=1)
        if win_end > end:
            win_end = end
        label = cursor.strftime("%Y-%m-%d")
        windows.append((_format_date(cursor), _format_date(win_end), label))
        cursor = win_end
    return windows


def _parse_date(s):
    """Accept YYYY-MM-DD, return tz-aware UTC midnight datetime."""
    return datetime.strptime(s, "%Y-%m-%d").replace(tzinfo=timezone.utc)


def _format_date(dt):
    return dt.strftime("%Y-%m-%d")


def format_row(item, workspace_url):
    """Format a notification item as a CSV row."""
    ts_raw = item["turbot"]["createTimestamp"]
    ts = datetime.fromisoformat(ts_raw.replace("Z", "+00:00"))
    ts_fmt = ts.strftime("%d-%b-%Y %H:%M:%S")
    ntype = item["notificationType"].upper().replace("_", " ")

    res_type = item["resource"].get("type") or {}
    cat_title = (res_type.get("category") or {}).get("title", "")
    type_title = res_type.get("title", "")
    type_msg = f"{cat_title} > {type_title}" if cat_title else type_title

    resource_title = item["resource"]["turbot"]["title"]
    resource_id = item["resource"]["turbot"]["id"]
    trunk = (item["resource"].get("trunk") or {}).get("title", "(deleted)")

    actor = item.get("actor") or {}
    identity = actor.get("identity") or {}
    actor_name = (identity.get("trunk") or {}).get("title", "")
    if not actor_name:
        actor_name = (identity.get("turbot") or {}).get("title", "")

    detail_url = f"{workspace_url}/apollo/notifications/{item['turbot']['id']}"

    return {
        "Timestamp": ts_fmt,
        "NotificationType": ntype,
        "Type / Message": type_msg,
        "Resource": resource_title,
        "Actor": actor_name,
        "ResourceId": resource_id,
        "TrunkPath": trunk,
        "Detail URL": detail_url,
    }


CSV_FIELDNAMES = [
    "Timestamp",
    "NotificationType",
    "Type / Message",
    "Resource",
    "Actor",
    "ResourceId",
    "TrunkPath",
    "Detail URL",
]


def write_csv(items, workspace_url, output_path):
    """Write items to CSV file."""
    with open(output_path, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=CSV_FIELDNAMES)
        writer.writeheader()
        for item in items:
            writer.writerow(format_row(item, workspace_url))
    return len(items)


def run_workspace(profile_name, args, resource_types, notification_types):
    """Fetch all windows for one workspace and write CSV(s)."""
    workspace, config = load_profile(profile_name)
    print(f"  Workspace: {workspace}")

    actor_id = args.actor_id
    if not actor_id:
        print("  Detecting Turbot Identity ID...", end=" ")
        detected = get_turbot_identity_id(config)
        if not detected:
            print("FAILED — specify --actor-id manually")
            return
        actor_id = str(detected)
        print(actor_id)

    windows = build_windows(args.days, args.from_, args.to)
    print(f"  Date windows: {len(windows)} ({windows[0][0]} → {windows[-1][1]})")

    all_items = []
    summary_rows = []

    for rt in resource_types:
        print(f"  Resource type: {rt}")
        for since_date, until_date, label in windows:
            base_filter = build_base_filter(
                rt, actor_id,
                since_date=since_date, until_date=until_date,
                notification_types=notification_types,
            )

            expected = None
            if not args.skip_preflight:
                expected = count_window(config, base_filter, timeout=args.probe_timeout)
                exp_str = expected if expected is not None else "?"
                print(f"  [{label}]  expected={exp_str}")

            if args.preflight_only:
                summary_rows.append((rt, label, expected, None, None))
                continue

            items, ok = fetch_window(
                config, base_filter,
                page_size=args.page_size,
                data_source=args.data_source,
            )
            print(f"  [{label}]  fetched={len(items)} ({'ok' if ok else 'partial'})")

            if expected is not None and ok and len(items) < expected * 0.95:
                print(f"    WARN: fetched < 95% of expected ({len(items)}/{expected})")

            summary_rows.append((rt, label, expected, len(items), ok))

            if items and args.per_window_csv:
                fname = f"{profile_name}-{_short_type(rt)}-{label}.csv"
                path = os.path.join(args.output_dir, fname)
                write_csv(items, workspace, path)
                print(f"    Per-window CSV: {path}")

            all_items.extend(items)

    if args.preflight_only:
        return

    if not all_items:
        print("  No resource activity found.")
        return

    created = sum(1 for i in all_items if i["notificationType"] == "resource_created")
    deleted = sum(1 for i in all_items if i["notificationType"] == "resource_deleted")
    updated = sum(1 for i in all_items if i["notificationType"] == "resource_updated")

    date_str = datetime.now(timezone.utc).strftime("%Y%m%d")
    span = (
        f"{args.from_}_to_{args.to}"
        if args.from_ and args.to
        else f"{args.days}d-{date_str}"
    )
    filename = f"{profile_name}-resource-activity-{span}.csv"
    output_path = os.path.join(args.output_dir, filename)
    count = write_csv(all_items, workspace, output_path)

    print()
    print(f"  Consolidated: {count} total"
          f" ({created} created, {deleted} deleted, {updated} updated)")
    print(f"  CSV: {output_path}")

    short_total = sum(1 for r in summary_rows if r[2] is not None and r[3] is not None and r[3] < r[2] * 0.95)
    if short_total:
        print(f"  WARN: {short_total} window(s) returned < 95% of expected — re-run individual days with --from/--to")


def _short_type(uri):
    """Extract a short label from a resource type URI for filenames."""
    if "/" in uri:
        return uri.rsplit("/", 1)[-1]
    return uri.replace(":", "_")


def main():
    parser = argparse.ArgumentParser(
        description="Pull resource activity from Guardrails workspaces (per-day windowed)",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Last 7 days, all default activity types, default snapshot type
  %(prog)s --profile my-workspace --days 7

  # 7 days of snapshot deletions only, with per-window CSVs (resumable)
  %(prog)s --profile my-workspace --days 7 \\
    --resource-type snapshot --notification-type resource_deleted \\
    --per-window-csv

  # Backfill a single window
  %(prog)s --profile my-workspace --resource-type snapshot \\
    --from 2026-05-01 --to 2026-05-02
        """,
    )
    parser.add_argument("--profile", action="append",
                        help="Turbot CLI profile name (repeatable).")
    parser.add_argument("--days", type=int, default=7,
                        help="Lookback in days (default: 7). Ignored if --from/--to given.")
    parser.add_argument("--from", dest="from_", help="Window start (YYYY-MM-DD or ISO8601).")
    parser.add_argument("--to", dest="to", help="Window end (YYYY-MM-DD or ISO8601).")
    parser.add_argument("--resource-type", action="append",
                        help="Resource type alias or full tmod URI (repeatable, comma-OK). "
                             "Default: snapshot. Run --list-types to see aliases.")
    parser.add_argument("--notification-type", action="append",
                        choices=list(DEFAULT_NOTIFICATION_TYPES),
                        help="Limit to specific notification types (repeatable). "
                             "Default: all three.")
    parser.add_argument("--actor-id",
                        help="Actor identity ID (default: auto-detect Turbot Identity).")
    parser.add_argument("--data-source", choices=["ALL", "DB"],
                        help="Notification data source (default: server default = ALL).")
    parser.add_argument("--page-size", type=int, default=PAGE_SIZE,
                        help=f"Page size for paginated fetch (default: {PAGE_SIZE}, matches console).")
    parser.add_argument("--output-dir", default=".",
                        help="Output directory for CSV files.")
    parser.add_argument("--per-window-csv", action="store_true",
                        help="Also write one CSV per day window (in addition to consolidated).")
    parser.add_argument("--preflight-only", action="store_true",
                        help="Run per-window count probes and exit without fetching items.")
    parser.add_argument("--skip-preflight", action="store_true",
                        help="Skip per-window count probes (faster but no expected/actual check).")
    parser.add_argument("--probe-timeout", type=int, default=PROBE_TIMEOUT,
                        help=f"Per-window count timeout in seconds (default: {PROBE_TIMEOUT}).")
    parser.add_argument("--list-types", action="store_true",
                        help="Print built-in resource-type aliases and exit.")

    args = parser.parse_args()

    if args.list_types:
        print("Resource-type aliases:")
        width = max(len(k) for k in RESOURCE_TYPE_ALIASES)
        for alias, uri in sorted(RESOURCE_TYPE_ALIASES.items()):
            print(f"  {alias:<{width}}  {uri}")
        return

    if not args.profile:
        parser.error("--profile is required (unless --list-types is used)")
    if bool(args.from_) ^ bool(args.to):
        parser.error("--from and --to must be given together")

    os.makedirs(args.output_dir, exist_ok=True)

    resource_types = (
        resolve_resource_types(args.resource_type)
        if args.resource_type
        else ["tmod:@turbot/aws-ec2#/resource/types/snapshot"]
    )
    notification_types = args.notification_type  # None means default trio in build_base_filter

    print("Resource Activity Report")
    print(f"Profiles:        {', '.join(args.profile)}")
    print(f"Resource types:  {', '.join(resource_types)}")
    print(f"Notif types:     {', '.join(notification_types or DEFAULT_NOTIFICATION_TYPES)}")
    if args.from_:
        print(f"Window:          {args.from_} → {args.to}")
    else:
        print(f"Window:          last {args.days} day(s)")
    print(f"Page size:       {args.page_size}")
    print(f"Data source:     {args.data_source or 'server default (ALL)'}")
    if args.preflight_only:
        print("Mode:            pre-flight only (counts, no fetch)")
    print(f"Output dir:      {os.path.abspath(args.output_dir)}")
    print()

    for profile_name in args.profile:
        print(f"[{profile_name}]")
        run_workspace(profile_name, args, resource_types, notification_types)
        print()

    print("Done.")


if __name__ == "__main__":
    main()
