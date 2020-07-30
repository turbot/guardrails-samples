import turbot
import click
import requests
from base64 import b64encode
import sys


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('-f', '--filter', default="state:tbd", help="[String] Used to filter out matching policies.")
@click.option('-e', '--execute', is_flag=True, help="Will re-run policies when found.")
def run_policies(config_file, profile, filter, execute):
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
    endpoint = config.graphql_endpoint

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
        result = run_query(endpoint, headers, query, variables)

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

        for policy in targets:
            vars = {'input': {'id': policy['turbot']['id']}}
            print(vars)
            try:
                run = run_query(endpoint, headers, mutation, vars)
                print(run)
            except Exception as e:
                print(e)


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
            run_policies()
        except Exception as e:
            print(e)
    else:
        print("This script requires Python v3.7+")
        print("Your Python version is: {}.{}.{}".format(
            sys.version_info.major, sys.version_info.minor, sys.version_info.micro))
        if (sys.version_info < (3, 0)):
            hint = ["Maybe try: `python3"] + sys.argv
            hint[len(sys.argv)] = hint[len(sys.argv)] + "`"
            print(*hint)
