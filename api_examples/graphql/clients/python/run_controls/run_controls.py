import click
import turbot
from sgqlc.endpoint.http import HTTPEndpoint
import pprint


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="Profile to be used from config file.")
@click.option('-f', '--filter', default="state:tbd", help="Filter to run.")
@click.option('--execute', is_flag=True, help="Will re-run controls when found.")
def run_controls(config_file, profile, filter, execute):
    """ Finds all controls matching the provided filter, then re-runs them if --execute is set."""
    """
        Example Filters
        ---------------
        Run controls in TBD (Default):      "state:tbd"
        Run controls in error state:        "state:error"
        Run controls in multiple states:    "state:tbd,error,alarm"
        Re-run installed controls:          "state:tbd,error controlType:'tmod:@turbot/turbot#/control/types/controlInstalled'"
        Re-run AWS Event Handler controls:  "controlType:'tmod:@turbot/aws#/control/types/eventHandlers'"
        Re-run Discovery controls:          "Discovery controlCategory:'tmod:@turbot/turbot#/control/categories/cmdb'"
    """

    config = turbot.Config(config_file, profile)
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    endpoint = HTTPEndpoint(config.graphql_endpoint, headers)

    query = '''
      query Targets($filter: [String!]!, $paging: String) {
        targets: controls(filter: $filter, paging: $paging) {
          items {
            turbot { id }
            state
          }
          paging {
            next
          }
        }
      }
    '''

    mutation = '''
      mutation RunControl($input: RunControlInput!) {
        runControl(input: $input) {
          turbot {
            id
          }
        }
      }
    '''

    targets = []
    paging = None
    print("Looking for targets...")

    while True:
        variables = {'filter': filter, 'paging': paging}
        result = endpoint(query, variables)
        for item in result['data']['targets']['items']:
            targets.append(item)
        if not result['data']['targets']['paging']['next']:
            break
        else:
            print("{} found...".format(len(targets)))
            paging = result['data']['targets']['paging']['next']

    print("\nFound {} Total Targets".format(len(targets)))

    if not execute:
        print("\n --execute flag not set... exiting.")
    else:
        for control in targets:
            vars = {'input': {'id': control['turbot']['id']}}
            print(vars)
            try:
                run = endpoint(mutation, vars)
                print(run)
            except Exception as e:
                print(e)


if __name__ == "__main__":
    run_controls()
