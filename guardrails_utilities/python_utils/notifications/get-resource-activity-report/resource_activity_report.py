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
PAGE_SIZE = 500

NOTIFICATIONS_QUERY = """
query ResourceActivity($filter: [String!], $paging: String) {
  notifications(filter: $filter, paging: $paging, dataSource: DB) {
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


def graphql_request(config, query, variables=None):
    """Execute a GraphQL query against the workspace."""
    payload = {"query": query}
    if variables:
        payload["variables"] = variables

    response = requests.post(
        config["endpoint"],
        json=payload,
        headers=config["headers"],
        timeout=300,
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


def fetch_all_pages(config, filter_str):
    """Fetch all pages for a given filter string."""
    all_items = []
    next_page = None
    page_num = 0

    while True:
        page_num += 1
        variables = {"filter": filter_str, "paging": next_page}

        max_retries = 3
        for attempt in range(1, max_retries + 1):
            try:
                result = graphql_request(config, NOTIFICATIONS_QUERY, variables)
                break
            except requests.exceptions.Timeout:
                if attempt < max_retries:
                    wait = attempt * 15
                    print(f"  Page {page_num}: timeout (attempt {attempt}/{max_retries}) — retrying in {wait}s...")
                    time.sleep(wait)
                else:
                    print(f"  Page {page_num}: timeout after {max_retries} attempts — stopping")
                    return all_items

        data = result.get("data") or {}
        notifications = data.get("notifications") or {}
        items = notifications.get("items") or []
        all_items.extend(items)

        paging = notifications.get("paging") or {}
        print(f"  Page {page_num}: {len(items)} items (total so far: {len(all_items)})")

        if paging and paging.get("next"):
            next_page = paging["next"]
        else:
            break

    return all_items


def fetch_resource_activity(config, resource_type_id, days, actor_id=None):
    """
    Fetch resource CRUD activity for a given resource type and actor.

    Fetches all resource_created/deleted/updated notifications without date
    filters (to avoid backend query plan timeouts on large datasets), then
    filters to the requested date range client-side.
    """
    if not actor_id:
        print("  Detecting Turbot Identity ID...", end=" ")
        detected_id = get_turbot_identity_id(config)
        if detected_id:
            actor_id = str(detected_id)
            print(actor_id)
        else:
            print("FAILED — specify --actor-id manually")
            return []

    safe_actor_id = str(actor_id)
    filter_str = (
        f"resourceType:'{resource_type_id}'"
        f" actorIdentityId:'{safe_actor_id}'"
        f" notificationType:resource_created,resource_deleted,resource_updated"
        f" sort:-createTimestamp"
        f" limit:{PAGE_SIZE}"
    )

    print(f"  Fetching resource activity for actor {safe_actor_id}...")
    all_items = fetch_all_pages(config, filter_str)

    if days and all_items:
        cutoff = datetime.now(timezone.utc) - timedelta(days=days)
        before_count = len(all_items)
        all_items = [
            i
            for i in all_items
            if datetime.fromisoformat(
                i["turbot"]["createTimestamp"].replace("Z", "+00:00")
            )
            >= cutoff
        ]
        print(
            f"  Date filter (last {days}d): {before_count} → {len(all_items)} items"
        )

    return all_items


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


def main():
    parser = argparse.ArgumentParser(
        description="Pull resource activity from Guardrails workspaces",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # EC2 snapshots deleted by Turbot, last 90 days
  %(prog)s --profile myworkspace --days 90

  # Multiple workspaces
  %(prog)s --profile ws1 --profile ws2 --days 30

  # S3 buckets instead of snapshots
  %(prog)s --profile myworkspace --days 30 \\
    --resource-type "tmod:@turbot/aws-s3#/resource/types/bucket"

  # Specific actor identity
  %(prog)s --profile myworkspace --days 90 --actor-id 123456789012345
        """,
    )
    parser.add_argument(
        "--profile",
        action="append",
        required=True,
        help="Turbot CLI profile name (repeatable for multiple workspaces)",
    )
    parser.add_argument(
        "--days",
        type=int,
        default=30,
        help="Number of days to look back (default: 30)",
    )
    parser.add_argument(
        "--resource-type",
        default="tmod:@turbot/aws-ec2#/resource/types/snapshot",
        help="Resource type URI to filter on (default: EC2 Snapshot)",
    )
    parser.add_argument(
        "--actor-id",
        help="Actor identity ID to filter on (default: auto-detect Turbot Identity)",
    )
    parser.add_argument(
        "--output-dir",
        default=".",
        help="Output directory for CSV files (default: current directory)",
    )

    args = parser.parse_args()
    os.makedirs(args.output_dir, exist_ok=True)

    print(f"Resource Activity Report — last {args.days} days")
    print(f"Profiles: {', '.join(args.profile)}")
    print(f"Resource type: {args.resource_type}")
    print(f"Output: {os.path.abspath(args.output_dir)}")
    print()

    for profile_name in args.profile:
        print(f"[{profile_name}]")
        workspace, config = load_profile(profile_name)
        print(f"  Workspace: {workspace}")

        items = fetch_resource_activity(
            config, args.resource_type, args.days, args.actor_id
        )

        if not items:
            print("  No resource activity found.")
            print()
            continue

        created = sum(
            1 for i in items if i["notificationType"] == "resource_created"
        )
        deleted = sum(
            1 for i in items if i["notificationType"] == "resource_deleted"
        )
        updated = sum(
            1 for i in items if i["notificationType"] == "resource_updated"
        )

        date_str = datetime.now(timezone.utc).strftime("%Y%m%d")
        filename = f"{profile_name}-resource-activity-{args.days}d-{date_str}.csv"
        output_path = os.path.join(args.output_dir, filename)

        count = write_csv(items, workspace, output_path)
        print(
            f"  Results: {count} total"
            f" ({created} created, {deleted} deleted, {updated} updated)"
        )
        print(f"  CSV: {output_path}")
        print()

    print("Done.")


if __name__ == "__main__":
    main()
