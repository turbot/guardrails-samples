#!/usr/bin/env python3
"""
Fetch 'Resources Deleted by Turbot' from a Guardrails workspace using the turbot
CLI, with pagination and CSV output matching the console export format.

Supports calendar-day boundaries (midnight-to-midnight UTC) for consistent
day-over-day tracking. Fetches all resource types by default when a time
boundary is provided; optionally filter to a specific resource type.

Usage:
    # All resource types deleted by Turbot on a single day
    python fetch_resource_deletions.py --profile kochgp --date 2026-05-07

    # Only snapshots
    python fetch_resource_deletions.py --profile kochgp --date 2026-05-07 \
        --resource-type snapshot

    # Date range, all types
    python fetch_resource_deletions.py --profile kochgp --since 2026-05-01 --until 2026-05-08

    # Rolling window
    python fetch_resource_deletions.py --profile kochgp --days 3
"""

import argparse
import csv
import json
import os
import subprocess
import sys
from datetime import datetime, timedelta

QUERY_FILE = os.path.join(os.path.dirname(__file__), "resource_deleted_by_turbot.graphql")
PAGE_SIZE = 200

WORKSPACE_URLS = {
    "kochgp": "https://gp.turbotprod.kochind.cloud",
    "kochkbs": "https://kbs.turbotprod.kochind.cloud",
    "kochkbxt": "https://kbxt.turbotprod.kochind.cloud",
    "kochgdn": "https://gdn.turbotprod.kochind.cloud",
    "kochinv": "https://inv.turbotprod.kochind.cloud",
    "kochind": "https://kochind.turbotprod.kochind.cloud",
    "kochkaes": "https://kaes.turbotprod.kochind.cloud",
    "kochfhr": "https://fhr.turbotprod.kochind.cloud",
    "kochkes": "https://kes.turbotprod.kochind.cloud",
    "kochkmt": "https://kmt.turbotprod.kochind.cloud",
    "kochmlx": "https://mlx.turbotprod.kochind.cloud",
}

TURBOT_IDENTITY_IDS = {
    "kochgp": "218162262814364",
}

RESOURCE_TYPE_ALIASES = {
    "snapshot": "tmod:@turbot/aws-ec2#/resource/types/snapshot",
    "ec2-snapshot": "tmod:@turbot/aws-ec2#/resource/types/snapshot",
    "instance": "tmod:@turbot/aws-ec2#/resource/types/instance",
    "ec2-instance": "tmod:@turbot/aws-ec2#/resource/types/instance",
    "volume": "tmod:@turbot/aws-ec2#/resource/types/volume",
    "ec2-volume": "tmod:@turbot/aws-ec2#/resource/types/volume",
    "ami": "tmod:@turbot/aws-ec2#/resource/types/image",
    "launch-template": "tmod:@turbot/aws-ec2#/resource/types/launchTemplate",
    "bucket": "tmod:@turbot/aws-s3#/resource/types/bucket",
    "s3-bucket": "tmod:@turbot/aws-s3#/resource/types/bucket",
    "function": "tmod:@turbot/aws-lambda#/resource/types/function",
    "lambda": "tmod:@turbot/aws-lambda#/resource/types/function",
    "function-version": "tmod:@turbot/aws-lambda#/resource/types/functionVersion",
    "role": "tmod:@turbot/aws-iam#/resource/types/role",
    "vpc": "tmod:@turbot/aws-vpc-core#/resource/types/vpc",
    "security-group": "tmod:@turbot/aws-vpc-security#/resource/types/securityGroup",
    "subscription": "tmod:@turbot/aws-sns#/resource/types/subscription",
    "ecs-service": "tmod:@turbot/aws-ecs#/resource/types/service",
}

CSV_HEADERS = [
    "Timestamp", "NotificationType", "Type / Message",
    "Resource", "Actor", "ResourceId", "TrunkPath", "Detail URL",
]


def resolve_resource_type(value):
    if value is None:
        return None
    if value.startswith("tmod:"):
        return value
    alias = RESOURCE_TYPE_ALIASES.get(value.lower())
    if alias:
        return alias
    print(f"Error: unknown resource type alias '{value}'.", file=sys.stderr)
    print(f"Known aliases: {', '.join(sorted(RESOURCE_TYPE_ALIASES.keys()))}", file=sys.stderr)
    print(f"Or pass a full tmod:@turbot/... URI.", file=sys.stderr)
    sys.exit(1)


def run_query(profile, variables):
    cmd = [
        "turbot", "graphql",
        "--profile", profile,
        "--format", "json",
        "--query", QUERY_FILE,
        "--variables", json.dumps(variables),
    ]
    result = subprocess.run(cmd, capture_output=True, text=True, timeout=600)
    if result.returncode != 0:
        print(f"turbot CLI error: {result.stderr.strip()}", file=sys.stderr)
        sys.exit(1)
    return json.loads(result.stdout)


def build_filter(actor_id, resource_type_uri, date, since, until, days):
    parts = ["notificationType:resource_deleted"]
    if actor_id:
        parts.append(f"actorIdentityId:{actor_id}")
    if resource_type_uri:
        parts.append(f"resourceTypeId:'{resource_type_uri}'")

    if date:
        next_day = (datetime.strptime(date, "%Y-%m-%d") + timedelta(days=1)).strftime("%Y-%m-%d")
        parts.append(f"timestamp:>{date}")
        parts.append(f"timestamp:<{next_day}")
    elif since and until:
        parts.append(f"timestamp:>{since}")
        parts.append(f"timestamp:<{until}")
    elif since:
        parts.append(f"timestamp:>{since}")
    else:
        start = (datetime.utcnow() - timedelta(days=days)).strftime("%Y-%m-%d")
        parts.append(f"timestamp:>{start}")

    filter_str = " ".join(parts)
    filters = [filter_str, f"limit:{PAGE_SIZE}"]

    return filters


def format_timestamp(iso_ts):
    dt = datetime.fromisoformat(iso_ts.replace("Z", "+00:00"))
    return dt.strftime("%d-%b-%Y %H:%M:%S")


def format_actor(actor):
    if not actor:
        return ""
    identity = actor.get("identity") or {}
    persona = actor.get("persona") or {}
    id_title = identity.get("title", "")
    pe_title = persona.get("title", "")
    if pe_title and pe_title != id_title:
        return f"{id_title} > {pe_title}"
    return id_title


def to_csv_row(item, workspace_url):
    ts = format_timestamp(item["turbot"]["createTimestamp"])
    nt = item["notificationType"].replace("_", " ").upper()
    resource = item.get("resource") or {}
    res_turbot = resource.get("turbot") or {}
    res_type_title = (resource.get("type") or {}).get("turbot", {}).get("title", "")
    trunk_title = (resource.get("trunk") or {}).get("title") or "(deleted)"
    type_msg = f"Object > {res_type_title}" if res_type_title else ""
    actor_str = format_actor(item.get("actor"))
    notif_id = item["turbot"]["id"]
    detail_url = f"{workspace_url}/apollo/notifications/{notif_id}"

    return [
        ts, nt, type_msg,
        res_turbot.get("title", ""),
        actor_str,
        res_turbot.get("id", ""),
        trunk_title,
        detail_url,
    ]


def main():
    parser = argparse.ArgumentParser(
        description="Fetch resource deletions by Turbot from a Guardrails workspace via turbot CLI",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
resource type aliases:
  snapshot, instance, volume, ami, launch-template, bucket,
  lambda, function-version, role, vpc, security-group,
  subscription, ecs-service

  Or pass a full URI: tmod:@turbot/aws-ec2#/resource/types/snapshot

examples:
  %(prog)s --profile kochgp --date 2026-05-07
  %(prog)s --profile kochgp --date 2026-05-07 --resource-type snapshot
  %(prog)s --profile kochgp --since 2026-05-01 --until 2026-05-08
  %(prog)s --profile kochgp --days 7 --resource-type instance
""",
    )
    parser.add_argument("--profile", required=True, help="Turbot CLI profile name (e.g. kochgp)")

    time_group = parser.add_argument_group("time range (pick one)")
    time_group.add_argument("--date", help="Single calendar day, midnight-to-midnight UTC (YYYY-MM-DD)")
    time_group.add_argument("--since", help="Start date inclusive (YYYY-MM-DD)")
    time_group.add_argument("--until", help="End date exclusive (YYYY-MM-DD), use with --since")
    time_group.add_argument("--days", type=int, default=1, help="Rolling window in days (default: 1)")

    parser.add_argument("--actor-id", help="Turbot actor identity ID (auto-detected for known workspaces)")
    parser.add_argument("--resource-type",
                        help="Resource type alias or tmod URI (default: all types)")
    parser.add_argument("--output", help="Output CSV file path (default: auto-generated)")
    parser.add_argument("--workspace-url", help="Workspace base URL (auto-detected for known workspaces)")
    args = parser.parse_args()

    actor_id = args.actor_id or TURBOT_IDENTITY_IDS.get(args.profile)
    workspace_url = args.workspace_url or WORKSPACE_URLS.get(args.profile, "")
    resource_type_uri = resolve_resource_type(args.resource_type)

    if not actor_id:
        print(f"Warning: no actor-id for profile '{args.profile}'. Fetching deletions by ALL actors.",
              file=sys.stderr)
    if not workspace_url:
        print(f"Warning: no workspace URL for profile '{args.profile}'. Detail URLs will be incomplete.",
              file=sys.stderr)

    if not resource_type_uri and not args.date and not args.since:
        print("Error: fetching all resource types without a time boundary is unsafe (millions of rows).",
              file=sys.stderr)
        print("Add --date, --since, or --resource-type to bound the query.", file=sys.stderr)
        sys.exit(1)

    filters = build_filter(actor_id, resource_type_uri, args.date, args.since, args.until, args.days)

    type_tag = args.resource_type or "all-types"
    date_tag = args.date or args.since or datetime.now().strftime("%Y%m%d")
    output_file = args.output or f"{args.profile}-resource-deleted-{type_tag}-{date_tag}.csv"

    scope = resource_type_uri or "all resource types"
    print(f"Profile:        {args.profile}")
    print(f"Resource type:  {scope}")
    print(f"Filters:        {filters}")
    print(f"Output:         {output_file}")
    print()

    paging = None
    page = 0
    total_written = 0

    with open(output_file, "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(CSV_HEADERS)

        while True:
            page += 1
            variables = {"filter": filters}
            if paging:
                variables["paging"] = paging

            data = run_query(args.profile, variables)
            notifications = data.get("notifications", {})
            items = notifications.get("items", [])

            for item in items:
                writer.writerow(to_csv_row(item, workspace_url))
            f.flush()
            total_written += len(items)

            print(f"  Page {page}: {len(items)} items (cumulative: {total_written})")

            paging = notifications.get("paging", {}).get("next")
            if not paging or not items:
                break

    print(f"\nDone. {total_written} rows written to {output_file}")


if __name__ == "__main__":
    main()
