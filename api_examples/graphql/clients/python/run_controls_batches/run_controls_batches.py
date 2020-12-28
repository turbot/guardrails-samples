import click
import turbot
from sgqlc.endpoint.http import HTTPEndpoint
import pprint
import time


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('-f', '--filter', default="state:tbd", help="[String] Used to filter out matching controls.")
@click.option('-b', '--batch', default=100, help="[Int] The number of controls to run before cooldown per cycle")
@click.option('-s', '--start-index', default=0, help="[Int] Sets the starting point in the returned control collection. All controls starting at the starting point will be run.")
@click.option('-d', '--cooldown', default=120, help="[Int] Number of seconds to pause before the next batch of controls are run. Setting this value to `0` will disable cooldown.")
@click.option('-m', '--max-batch', default=-1, help="[Int] The maximum number of batches to run. The value `-1` will run all the returned controls from the starting point.")
@click.option('-e', '--execute', is_flag=True, help="Will re-run controls when found.")
def run_controls(config_file, profile, filter, batch, start_index, cooldown, max_batch, execute):
    """ Finds all controls matching the provided filter, then re-runs them if --execute is set."""
    """
        Example Filters
        ---------------
        Run controls in TBD state (Default):  "state:tbd"
        Run controls in error state:          "state:error"
        Run controls in multiple states:      "state:tbd,error,alarm"
        Re-run installed controls:            "state:tbd,error controlType:'tmod:@turbot/turbot#/control/types/controlInstalled'"
        Re-run AWS Event Handler controls:    "controlType:'tmod:@turbot/aws#/control/types/eventHandlers'"
        Re-run Discovery controls:            "Discovery controlCategory:'tmod:@turbot/turbot#/control/categories/cmdb'"
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

    targets = []
    paging = None
    print("Looking for targets...")

    while True:
        variables = {'filter': filter, 'paging': paging}
        result = endpoint(query, variables)

        if "errors" in result:
            for error in result['errors']:
                print(error)
            break

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
        mutation = '''
          mutation RunControl($input: RunControlInput!) {
            runControl(input: $input) {
              turbot {
                id
              }
            }
          }
        '''

        total_batches = 0
        for index in range(start_index, len(targets)):
            control = targets[index]
            vars = {'input': {'id': control['turbot']['id']}}
            print(vars)
            try:
                run = endpoint(mutation, vars)
                print(run)
            except Exception as e:
                print(e)

            if ((index - start_index + 1) % batch == 0):
                total_batches = total_batches + 1
                time.sleep(cooldown)
                if (total_batches == max_batch):
                    break


if __name__ == "__main__":
    try:
        run_controls()
    except Exception as e:
        print(e)
