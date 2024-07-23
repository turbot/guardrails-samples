#!/usr/bin/env python
import click
import configparser
import json
import requests
from datetime import datetime, timedelta
from dateutil import parser

def get_date_range(start_date, end_date):
    date_range = []
    parsed_start_date = parser.parse(start_date)
    parsed_end_date = parser.parse(end_date)
    delta = parsed_end_date - parsed_start_date
    for i in range(delta.days + 1):
        day = parsed_start_date + timedelta(days=i)
        date_range.append(day.strftime('%Y-%m-%d'))
    return date_range

@click.command()
@click.option('-w', '--workspace', required=True, help='Workspace alias to look up URL and and access key pair from config e.g. acme.')
@click.option('-s', '--start-date', required=True, help='Start date of usage period in ISO format YYYYMMDD.')
@click.option('-e', '--end-date', required=True, help='End date of usage period in ISO format YYYYMMDD.')
@click.option('-o', '--output', required=False, help='Output format of usage breakdown, can be one of "csv" or "json". Defaults to "csv".')
def get_workspace_usage(workspace, start_date, end_date, output):
    """This program gets workspace usage for a given time period"""

    print('Please wait. This may take some time...\n')
    config = configparser.ConfigParser()
    config.read("workspaces.conf")
    workspace_config = config[workspace]
    # Set GraphQL API Params
    turbot_workspace_url = workspace_config.get('workspaceURL')
    turbot_access_key = workspace_config.get('accessKey')
    turbot_secret = workspace_config.get('secret')
    turbot_workspace_certificate_verification = workspace_config.getboolean('verifySSL', fallback=True)

    if not turbot_workspace_certificate_verification:
        requests.packages.urllib3.disable_warnings()

    api_url = "{}/api/v5/graphql".format(turbot_workspace_url)
    query = '''
query ControlUsages($filter: [String!]!, $paging: String) {
  controlUsagesByControlType(filter: $filter, paging: $paging) {
    items {
      type {
        trunk {
          title
        }
        uri
      }
      summary {
        activeControlDays
        inactiveControls
        states {
          alarm
          invalid
          error
          ok
          tbd
          skipped
        }
      }
    }
    paging {
      next
    }
  }
}
'''

    date_range_to_query = get_date_range(start_date, end_date)
    active_control_days_non_turbot = 0
    active_control_days_turbot = 0

    output = 'csv' if output == None else output

    if output == 'csv':
        usage_output_file = '{}_{}_{}_control_usage_breakdown.csv'.format(workspace, start_date, end_date)
    elif output == 'json':
        usage_output_file = '{}_{}_{}_control_usage_breakdown.json'.format(workspace, start_date, end_date)

    with open(usage_output_file, 'w') as breakdown_outfile:
      if output == 'csv':
          breakdown_outfile.write('Period,Title,Control Type URI,ActiveControlDays,InactiveControls,Alarm,Error,Invalid,OK,Skipped,TBD\n')
      for date_to_query in date_range_to_query:
          print("Querying data for {}".format(parser.parse(date_to_query).strftime('%Y-%m-%d')))
          has_more = True
          next_token = None
          workspace_usage_items = []
          json_data = {}
          control_data = {}
          control_usage = []

          if output == 'json':
              json_data['licenseId'] = '[licenseId]'
              json_data['workspaceId'] = '[workspaceId]'
              json_data['period'] = parser.parse(date_to_query).strftime('%Y-%m-%d')
              control_data['version'] = '2020-07-22'

          while has_more:
              # Build variables with paging token from previous run
              query_timestamp = parser.parse(date_to_query).strftime('%Y%m%d2359')
              variables = {'filter': 'timestamp:{} limit:300'.format(query_timestamp), 'paging': next_token}

              # Fetch raw data
              response = requests.post(
                  api_url,
                  auth=(turbot_access_key, turbot_secret),
                  verify=turbot_workspace_certificate_verification,
                  headers={
                  'content-type': "application/json",
                  'cache-control': "no-cache"
                  },
                  json={'query': query, 'variables': variables}
              )

              if not response.ok:
                  print(response.text)
                  response.raise_for_status()

              # Convert the response JSON into a Python object
              raw_workspace_usage = json.loads(response.text)
              response.close()

              next_token = raw_workspace_usage['data']['controlUsagesByControlType']['paging']['next']
              has_more = True if next_token else False

              # Concatenate results into one
              raw_workspace_usage_items = raw_workspace_usage['data']['controlUsagesByControlType']['items']
              workspace_usage_items = workspace_usage_items + raw_workspace_usage_items

          # Sort by title (we'd like to sort by the control trunk title, but we're getting a null trunk
          # if the control type has been deleted - so URI will do for now)
          workspace_usage_items.sort(key=lambda x: x['type']['uri'])

          # Initialise stats
          active_turbot_control_days_for_period = 0
          active_non_turbot_control_days_for_period = 0
          inactive_turbot_control_days_for_period = 0
          inactive_non_turbot_control_days_for_period = 0
          turbot_control_usage_by_uri = {}
          non_turbot_control_usage_by_uri = {}

          for workspace_usage_item in workspace_usage_items:
              workspace_usage_summary = workspace_usage_item['summary']
              active_control_days_total = workspace_usage_summary['activeControlDays']
              inactive_controls_total = workspace_usage_summary['inactiveControls']
              states_summary = workspace_usage_summary['states']
              alarm_total = states_summary['alarm']
              error_total = states_summary['error']
              invalid_total = states_summary['invalid']
              ok_total = states_summary['ok']
              skipped_total = states_summary['skipped']
              tbd_total = states_summary['tbd']
              control_type_uri = workspace_usage_item['type']['uri']
              mod_title = workspace_usage_item['type']['trunk']['title'] if workspace_usage_item['type']['trunk'] else workspace_usage_item['type']['uri']
              is_turbot_mod = 'tmod:@turbot/turbot' in control_type_uri

              totals = {
                  'activeControlDays': active_control_days_total,
                  'inactiveControls': inactive_controls_total,
                  'alarm': alarm_total,
                  'error': error_total,
                  'invalid': invalid_total,
                  'ok': ok_total,
                  'skipped': skipped_total,
                  'tbd': tbd_total,
              }

              # Increment active/inactive totals
              if is_turbot_mod:
                  active_turbot_control_days_for_period += active_control_days_total
                  inactive_turbot_control_days_for_period += inactive_controls_total
                  turbot_control_usage_by_uri[control_type_uri] = {
                      'title': mod_title,
                      'summary': totals
                  }
              else:
                  active_non_turbot_control_days_for_period += active_control_days_total
                  inactive_non_turbot_control_days_for_period += inactive_controls_total
                  non_turbot_control_usage_by_uri[control_type_uri] = {
                      'title': mod_title,
                      'summary': totals
                  }

              if output == 'csv':
                  breakdown_outfile.write('{},{},{},{},{},{},{},{},{},{},{}\n'.format(date_to_query, mod_title, control_type_uri, active_control_days_total, inactive_controls_total, alarm_total, error_total, invalid_total, ok_total, skipped_total, tbd_total))
              else:
                  control_usage.append(
                    {
                      'uri': control_type_uri,
                      'error': error_total,
                      'alarm': alarm_total,
                      'invalid': invalid_total,
                      'ok': ok_total,
                      'tbd': tbd_total,
                      'skipped': skipped_total,
                      'activeControlDays': active_control_days_total,
                      'inactiveControls': inactive_controls_total
                    }
                  )        

          if output == 'json':
              control_data['usage'] = control_usage
              json_data['control'] = control_data
              json_string = json.dumps(json_data)
              breakdown_outfile.write(json_string)

          active_control_days_non_turbot += active_non_turbot_control_days_for_period
          active_control_days_turbot += active_turbot_control_days_for_period

    summary_output_file = '{}_{}_{}_control_usage_summary.txt'.format(workspace, start_date, end_date)
    with open(summary_output_file, 'w') as summary_outfile:
        padded_active_control_days_non_turbot = str(active_control_days_non_turbot).rjust(7, ' ')
        padded_active_control_days_turbot = str(active_control_days_turbot).rjust(7, ' ')

        summary_outfile.write('Active Non-Turbot Control Days (billable)\n')
        summary_outfile.write('-------------------\n')
        summary_outfile.write('{}\n\n'.format(padded_active_control_days_non_turbot))
        summary_outfile.write('Active Turbot Control Days\n')
        summary_outfile.write('---------------\n')
        summary_outfile.write('{}\n'.format(padded_active_control_days_turbot))

        print('')
        print('Active Non-Turbot Control Days (billable)')
        print('-----------------------')
        print(padded_active_control_days_non_turbot)
        print('')
        print('')
        print('Active Turbot Control Days')
        print('-------------------')
        print(padded_active_control_days_turbot)
        print('')


if __name__ == '__main__':
    get_workspace_usage()