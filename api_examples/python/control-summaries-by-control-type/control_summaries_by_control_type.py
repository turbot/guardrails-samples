import turbot
import click
import csv
import requests
import sys


CSP_CONTROL_TYPES = {
    'aws': "tmod:@turbot/aws#/resource/types/aws",
    'azure': "tmod:@turbot/azure#/resource/types/azure",
    'gcp': "tmod:@turbot/gcp#/resource/types/gcp",
}

QUERY = '''
  query ControlSummariesByControlType($filter: [String!], $paging: String) {
    controlSummaries: controlSummariesByControlType(
      filter: $filter
      paging: $paging
    ) {
      metadata {
        stats {
          control {
            total
          }
        }
      }
      items {
        type {
          uri
          trunk {
            title
            items {
              turbot {
                id
                title
              }
            }
          }
          turbot {
            id
            title
          }
        }
        summary {
          control {
            total
            alarm
            invalid
            error
            ok
            skipped
            tbd
          }
        }
      }
      paging {
        next
      }
    }
  }
'''


def fetch_pages(endpoint, headers, filter_str, sort, limit):
    """Fetch control type summaries, paging through all results up to limit."""
    items = []
    paging = None
    filter_parts = ["sort:{} limit:{}".format(sort, limit), filter_str]
    first_page = True

    while True:
        variables = {'filter': filter_parts, 'paging': paging}
        result = run_query(endpoint, headers, QUERY, variables)

        if "errors" in result:
            for error in result['errors']:
                print(error)
            break

        data = result['data']['controlSummaries']

        if first_page and data.get('metadata', {}).get('stats', {}).get('control', {}).get('total'):
            first_page = False
            total = data['metadata']['stats']['control']['total']
            print("Total controls matching filter: {}".format(total))

        for item in data['items']:
            items.append(item)
            if len(items) >= limit:
                break

        if len(items) >= limit or not data['paging']['next']:
            break
        paging = data['paging']['next']

    return items[:limit]


def build_row(item, level, parent_title):
    controls = item['summary']['control']
    trunk_titles = " > ".join(
        t['turbot']['title'] for t in item['type']['trunk']['items']
    ) if item['type']['trunk']['items'] else ""
    return {
        'level': level,
        'parent_control_type': parent_title or '',
        'control_type_title': item['type']['turbot']['title'],
        'control_type_uri': item['type']['uri'],
        'control_type_id': item['type']['turbot']['id'],
        'trunk': trunk_titles,
        'total': controls['total'],
        'ok': controls['ok'],
        'alarm': controls['alarm'],
        'error': controls['error'],
        'invalid': controls['invalid'],
        'tbd': controls['tbd'],
        'skipped': controls['skipped'],
    }


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('--csp', default="aws", type=click.Choice(['aws', 'azure', 'gcp'], case_sensitive=False), help="[String] Cloud service provider. Default: aws.")
@click.option('--state', default="active", help="[String] Control states to include, comma-delimited. Default: active. e.g. alarm,error,invalid")
@click.option('-s', '--sort', default="-total", help="[String] Sort order for results. Default: -total (descending by total).")
@click.option('-l', '--limit', default=100, type=int, help="[Int] Maximum number of parent control types to return.")
@click.option('-o', '--output', default="control_summaries.csv", help="[String] Output CSV file path.")
def control_summaries_by_control_type(config_file, profile, csp, state, sort, limit, output):
    """Queries control summaries grouped by control type, with child breakdown, and exports to CSV."""

    control_type_id = CSP_CONTROL_TYPES[csp.lower()]
    parent_filter = "controlTypeId:'{}' state:{}".format(control_type_id, state)

    config = turbot.Config(config_file, profile)
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    endpoint = config.graphql_endpoint

    print("Looking for control summaries...")
    parents = fetch_pages(endpoint, headers, parent_filter, sort, limit)

    print("\nFound {} control type(s), fetching children...".format(len(parents)))

    if not parents:
        print("No results to export.")
        return

    rows = []
    for parent in parents:
        parent_uri = parent['type']['uri']
        parent_title = parent['type']['turbot']['title']

        rows.append(build_row(parent, level='parent', parent_title=None))

        child_filter = "controlTypeId:'{}' state:{}".format(parent_uri, state)
        children = fetch_pages(endpoint, headers, child_filter, sort, 500)
        children = [c for c in children if c['type']['uri'] != parent_uri]

        for child in children:
            rows.append(build_row(child, level='child', parent_title=parent_title))

    # --- terminal table ---
    table_columns = ['control_type_title', 'total', 'ok', 'alarm', 'error', 'invalid', 'tbd', 'skipped']
    col_headers = {
        'control_type_title': 'Control Type',
        'total': 'Total',
        'ok': 'OK',
        'alarm': 'Alarm',
        'error': 'Error',
        'invalid': 'Invalid',
        'tbd': 'TBD',
        'skipped': 'Skipped',
    }

    display_labels = []
    for row in rows:
        if row['level'] == 'child':
            display_labels.append("  " + row['control_type_title'])
        else:
            display_labels.append(row['control_type_title'])

    col_widths = {}
    for col in table_columns:
        if col == 'control_type_title':
            col_widths[col] = max(len(col_headers[col]), max(len(lbl) for lbl in display_labels))
        else:
            col_widths[col] = max(len(col_headers[col]), max(len(str(row[col])) for row in rows))

    header_line = "  ".join(col_headers[col].ljust(col_widths[col]) if col == 'control_type_title'
                            else col_headers[col].rjust(col_widths[col])
                            for col in table_columns)
    separator = "  ".join("-" * col_widths[col] for col in table_columns)

    print("\n{}".format(header_line))
    print(separator)
    for row, label in zip(rows, display_labels):
        line = "  ".join(label.ljust(col_widths['control_type_title']) if col == 'control_type_title'
                         else str(row[col]).rjust(col_widths[col])
                         for col in table_columns)
        print(line)

    # --- CSV ---
    csv_columns = [
        'level',
        'parent_control_type',
        'control_type_title',
        'control_type_uri',
        'control_type_id',
        'trunk',
        'total',
        'ok',
        'alarm',
        'error',
        'invalid',
        'tbd',
        'skipped',
    ]

    with open(output, 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=csv_columns)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)

    print("\nResults written to {}".format(output))


def run_query(endpoint, headers, query, variables):
    request = requests.post(
        endpoint,
        headers=headers,
        json={'query': query, 'variables': variables}
    )
    if request.status_code == 200:
        return request.json()
    else:
        raise Exception("Query failed to run by returning code of {}. {}".format(
            request.status_code, query))


if __name__ == "__main__":
    if (sys.version_info > (3, 4)):
        try:
            control_summaries_by_control_type()
        except Exception as e:
            print(e)
    else:
        print("This script requires Python v3.5+")
        print("Your Python version is: {}.{}.{}".format(
            sys.version_info.major, sys.version_info.minor, sys.version_info.micro))
        if (sys.version_info < (3, 0)):
            hint = ["Maybe try: `python3"] + sys.argv
            hint[len(sys.argv)] = hint[len(sys.argv)] + "`"
            print(*hint)
