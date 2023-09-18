import click
import turbot
from sgqlc.endpoint.http import HTTPEndpoint
import time


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('-f', '--filter', default="state:tbd", help="Used to filter out matching policies.")
@click.option('-b', '--batch', default=100, help="[Int] The number of policies to run before cooldown per cycle")
@click.option('-s', '--start-index', default=0, help="[Int] Sets the starting point in the returned control collection. All policies starting at the starting point will be run.")
@click.option('-d', '--cooldown', default=120, help="[Int] Number of seconds to pause before the next batch of policies are run. Setting this value to `0` will disable cooldown.")
@click.option('-m', '--max-batch', default=-1, help="[Int] The maximum number of batches to run. The value `-1` will run all the returned policies from the starting point.")
@click.option('-e', '--execute', is_flag=True, help="Will re-run policies when found.")
def run_policies(config_file, profile, filter, batch, start_index, cooldown, max_batch, execute):
    """ Finds all policies matching the provided filter, then re-runs them if --execute is set."""
    """
        Example Filters
        ---------------
        Run policies in TBD (Default):          "state:tbd"
        Run policies in error state:            "state:error"
        Run policies in multiple states:        "state:tbd,error,invalid"
        Re-run CMDB policies:                   "controlCategoryId:'tmod:@turbot/turbot#/control/categories/cmdb'"
        Re-run policies that match policy type: "policyTypeId:'tmod:@turbot/azure-activedirectory#/policy/types/directoryCmdb'"
    """

    config = turbot.Config(config_file, profile)
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    endpoint = HTTPEndpoint(config.graphql_endpoint, headers)

    query = '''
      query Targets($filter: [String!]!, $paging: String) {
        targets: policyValues(filter: $filter, paging: $paging) {
          items {
            turbot {
              id
            }
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
          mutation RunPolicy($input: RunPolicyInput!) {
            runPolicy(input: $input) {
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
        run_policies()
    except Exception as e:
        print(e)
