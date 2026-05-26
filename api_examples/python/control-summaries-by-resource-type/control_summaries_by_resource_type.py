import turbot
import click
import csv
import requests
import sys


CSP_RESOURCE_TYPES = {
    'aws': "tmod:@turbot/aws#/resource/types/aws",
    'azure': "tmod:@turbot/azure#/resource/types/azure",
    'gcp': "tmod:@turbot/gcp#/resource/types/gcp",
}


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('--csp', default="aws", type=click.Choice(['aws', 'azure', 'gcp'], case_sensitive=False), help="[String] Cloud service provider. Default: aws.")
@click.option('--state', default="active", help="[String] Control states to include, comma-delimited. Default: active. e.g. alarm,error,invalid")
@click.option('-s', '--sort', default="-total", help="[String] Sort order for results. Default: -total (descending by total).")
@click.option('-l', '--limit', default=100, type=int, help="[Int] Maximum number of resource types to return.")
@click.option('-o', '--output', default="control_summaries.csv", help="[String] Output CSV file path.")
def control_summaries_by_resource_type(config_file, profile, csp, state, sort, limit, output):
    """Queries control summaries grouped by resource type and exports results to CSV."""

    resource_type_id = CSP_RESOURCE_TYPES[csp.lower()]
    filter = "resourceTypeId:'{}' state:{}".format(resource_type_id, state)

    config = turbot.Config(config_file, profile)
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    endpoint = config.graphql_endpoint

    query = '''
      query ControlSummariesByResourceType($filter: [String!], $paging: String) {
        controlSummaries: controlSummariesByResourceType(
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
            mode: type {
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

    items = []
    paging = None
    filter_parts = ["sort:{} limit:{}".format(sort, limit), filter]

    print("Looking for control summaries...")

    while True:
        variables = {'filter': filter_parts, 'paging': paging}
        result = run_query(endpoint, headers, query, variables)

        if "errors" in result:
            for error in result['errors']:
                print(error)
            break

        data = result['data']['controlSummaries']

        if not items and data.get('metadata', {}).get('stats', {}).get('control', {}).get('total'):
            total = data['metadata']['stats']['control']['total']
            print("Total controls matching filter: {}".format(total))

        for item in data['items']:
            items.append(item)
            if len(items) >= limit:
                break

        if len(items) >= limit or not data['paging']['next']:
            break
        else:
            print("{} resource types found...".format(len(items)))
            paging = data['paging']['next']

    items = items[:limit]

    print("\nFound {} resource type(s)".format(len(items)))

    if not items:
        print("No results to export.")
        return

    rows = []
    for item in items:
        controls = item['summary']['control']
        trunk_titles = " > ".join(
            t['turbot']['title'] for t in item['mode']['trunk']['items']
        ) if item['mode']['trunk']['items'] else ""
        rows.append({
            'resource_type_title': item['mode']['turbot']['title'],
            'resource_type_uri': item['mode']['uri'],
            'resource_type_id': item['mode']['turbot']['id'],
            'trunk': trunk_titles,
            'total': controls['total'],
            'ok': controls['ok'],
            'alarm': controls['alarm'],
            'error': controls['error'],
            'invalid': controls['invalid'],
            'tbd': controls['tbd'],
            'skipped': controls['skipped'],
        })

    table_columns = ['resource_type_title', 'total', 'ok', 'alarm', 'error', 'invalid', 'tbd', 'skipped']
    col_headers = {
        'resource_type_title': 'Resource Type',
        'total': 'Total',
        'ok': 'OK',
        'alarm': 'Alarm',
        'error': 'Error',
        'invalid': 'Invalid',
        'tbd': 'TBD',
        'skipped': 'Skipped',
    }
    col_widths = {}
    for col in table_columns:
        col_widths[col] = max(
            len(col_headers[col]),
            max(len(str(row[col])) for row in rows)
        )

    header_line = "  ".join(col_headers[col].ljust(col_widths[col]) if col == 'resource_type_title'
                            else col_headers[col].rjust(col_widths[col])
                            for col in table_columns)
    separator = "  ".join("-" * col_widths[col] for col in table_columns)

    print("\n{}".format(header_line))
    print(separator)
    for row in rows:
        line = "  ".join(str(row[col]).ljust(col_widths[col]) if col == 'resource_type_title'
                         else str(row[col]).rjust(col_widths[col])
                         for col in table_columns)
        print(line)

    csv_columns = [
        'resource_type_title',
        'resource_type_uri',
        'resource_type_id',
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
            control_summaries_by_resource_type()
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
