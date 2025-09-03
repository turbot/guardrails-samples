#!/usr/bin/env python3
import datetime as dt
import argparse
import sys
from _turbot import Config


def parse_arguments():
    """Parse command line arguments."""
    parser = argparse.ArgumentParser(
        description="Report Turbot Guardrails errors and alarms",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s                           # Default: errors/alarms in last 24h
  %(prog)s --hours 48                # Last 48 hours
  %(prog)s --states error            # Only ERROR states
  %(prog)s --states alarm            # Only ALARM states
  %(prog)s --states error,alarm      # Both ERROR and ALARM states
  %(prog)s --resource-type s3        # Only S3 resources (short form)
  %(prog)s --resource-type "tmod:@turbot/aws-s3#/resource/types/bucket"  # Specific S3 bucket type
  %(prog)s --output json             # JSON output format
  %(prog)s --quiet                   # Only show count
  %(prog)s --no-timestamp            # Don't filter by time
  %(prog)s --insecure                # Disable SSL certificate verification
        """
    )
    
    parser.add_argument(
        "--hours",
        type=int,
        default=24,
        help="Time window in hours (default: 24)"
    )
    
    parser.add_argument(
        "--states", "-s",
        default="error,alarm",
        help="Control states to include: error, alarm, ok, skipped, tbd (default: error,alarm)"
    )
    
    parser.add_argument(
        "--resource-type", "-r",
        help="Filter by resource type. Can use short form (s3, ec2, iam) or full URI (tmod:@turbot/aws-s3#/resource/types/bucket)"
    )
    
    # Note: Cloud provider filtering not available in controls API
    # parser.add_argument(
    #     "--cloud-provider", "-c",
    #     choices=["aws", "azure", "gcp"],
    #     help="Filter by cloud provider (aws, azure, gcp)"
    # )
    
    parser.add_argument(
        "--output", "-o",
        choices=["text", "json", "csv"],
        default="text",
        help="Output format (default: text)"
    )
    
    parser.add_argument(
        "--quiet", "-q",
        action="store_true",
        help="Only show count, no details"
    )
    
    parser.add_argument(
        "--no-timestamp",
        action="store_true",
        help="Don't filter by timestamp (show all matching states)"
    )
    
    parser.add_argument(
        "--limit", "-l",
        type=int,
        help="Limit number of results (for testing)"
    )
    
    parser.add_argument(
        "--debug",
        action="store_true",
        help="Enable debug output"
    )
    
    parser.add_argument(
        "--insecure", "-i",
        action="store_true",
        help="Disable SSL certificate verification"
    )
    
    return parser.parse_args()

def build_filters(args):
    """Build filter list based on command line arguments."""
    filters = []
    
    # State filter
    if args.states:
        filters.append(f"state:{args.states}")
    
    # Timestamp filter
    if not args.no_timestamp:
        filters.append(f"timestamp:>=T-{args.hours}h")
    
    # Resource type filter (supports both short form and full URI)
    if args.resource_type:
        if args.resource_type.startswith("tmod:"):
            # Full URI format: tmod:@turbot/aws-s3#/resource/types/bucket
            filters.append(f"resourceTypeId:{args.resource_type}")
        else:
            # Short form: s3, ec2, iam
            filters.append(f"resourceType:{args.resource_type}")
    
    # Note: Cloud provider filtering not available in controls API
    # if args.cloud_provider:
    #     provider_title = args.cloud_provider.upper()
    #     filters.append(f"typeTitle:{provider_title} > *")
    
    return filters

def format_output(controls, args):
    """Format output based on requested format."""
    if args.quiet:
        return f"Total: {len(controls)}"
    
    if args.output == "json":
        import json
        return json.dumps(controls, indent=2)
    
    elif args.output == "csv":
        import csv
        import io
        output = io.StringIO()
        writer = csv.writer(output)
        writer.writerow(["Timestamp", "Control Type", "Resource", "Resource ID", "State", "Reason"])
        for c in controls:
            writer.writerow([
                c['turbot']['stateChangeTimestamp'],
                c['type']['trunk']['title'],
                c['resource']['trunk']['title'],
                c['resource']['turbot']['id'],
                c['state'],
                c.get('reason', '')
            ])
        return output.getvalue()
    
    else:  # text format
        lines = []
        for c in controls:
            lines.append(
                f"[{c['turbot']['stateChangeTimestamp']}] "
                f"{c['type']['trunk']['title']} | Resource: {c['resource']['trunk']['title']} "
                f"(rid:{c['resource']['turbot']['id']}) | State: {c['state']} | Reason: {c.get('reason')}"
            )
        lines.append(f"\nTotal: {len(controls)}")
        return "\n".join(lines)

def main():
    """Main function."""
    args = parse_arguments()
    
    if args.debug:
        print(f"Debug: Arguments: {args}", file=sys.stderr)
    
    # Build filters
    filters = build_filters(args)
    if args.debug:
        print(f"Debug: Filters: {filters}", file=sys.stderr)
    
    # GraphQL query
    query = """
    query Controls($filter: [String!], $paging: String) {
      controls(filter: $filter, paging: $paging) {
        items {
          state
          reason
          turbot {
            id
            stateChangeTimestamp
          }
          type {
            trunk { title }
            uri
          }
          resource {
            trunk { title }
            turbot { id }
          }
        }
        paging {
          next
        }
      }
    }
    """
    
    variables = {
        "filter": filters,
        "paging": None
    }
    
    # Initialize Turbot configuration
    config = Config(None, "default", debug=args.debug, insecure=args.insecure)
    
    def run_query(q, v):
        result = config.graphql_query(q, v)
        return result["data"]
    
    # Fetch all results
    all_controls = []
    count = 0
    
    while True:
        data = run_query(query, variables)
        page = data["controls"]
        all_controls.extend(page["items"])
        count += len(page["items"])
        
        if args.debug:
            print(f"Debug: Fetched {len(page['items'])} controls, total: {count}", file=sys.stderr)
        
        # Check limit
        if args.limit and count >= args.limit:
            all_controls = all_controls[:args.limit]
            break
        
        # Check pagination
        if not page.get("paging", {}).get("next"):
            break
        variables["paging"] = page["paging"]["next"]
    
    # Output results
    print(format_output(all_controls, args))

if __name__ == "__main__":
    main()
