import click
import turbot
import requests
import time
from datetime import datetime

TOTAL_QUERY = '''
  query TargetCount($filter: [String!]!) {
    controls(filter: $filter) {
      metadata {
        stats {
          total
        }
      }
    }
  }
'''

PAGE_QUERY = '''
  query TargetPage($filter: [String!]!, $paging: String) {
    controls(filter: $filter, paging: $paging) {
      items {
        turbot { id }
      }
      paging {
        next
      }
    }
  }
'''

RUN_MUTATION = '''
  mutation RunControl($input: RunControlInput!) {
    runControl(input: $input) {
      turbot {
        id
      }
    }
  }
'''

MAX_ATTEMPTS = 3
RETRY_WAIT = 5


def graphql(session, endpoint_url, headers, query, variables):
    """ Posts a GraphQL request, retrying transient network/HTTP failures.
        Returns the `data` dict, or raises RuntimeError on GraphQL errors. """
    last_error = None
    for attempt in range(1, MAX_ATTEMPTS + 1):
        try:
            response = session.post(
                endpoint_url,
                json={'query': query, 'variables': variables},
                headers=headers
            )
            response.raise_for_status()
            result = response.json()

            if "errors" in result:
                messages = "; ".join(e['message'] for e in result["errors"])
                raise RuntimeError(messages)

            return result['data']

        except requests.exceptions.RequestException as e:
            last_error = e
            if attempt < MAX_ATTEMPTS:
                print(f"Request failed ({e}), retrying in {RETRY_WAIT} seconds "
                      f"(attempt {attempt} of {MAX_ATTEMPTS})...")
                time.sleep(RETRY_WAIT)

    raise RuntimeError(f"Request failed after {MAX_ATTEMPTS} attempts: {last_error}")


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('-f', '--filter', default="state:tbd", help="[String] Used to filter out matching controls.")
@click.option('-b', '--batch', default=100, help="[Int] Page size, and the number of controls to run before cooldown per cycle.")
@click.option('-d', '--cooldown', default=120, help="[Int] Number of seconds to pause between batches. Setting this value to `0` will disable cooldown.")
@click.option('-m', '--max-controls', default=-1, help="[Int] Maximum number of controls to run before stopping. The value `-1` runs until the filter is drained.")
@click.option('--max-passes', default=-1, help="[Int] Maximum number of passes over the filter. The value `-1` keeps passing until a pass finds no new controls.")
@click.option('-e', '--execute', is_flag=True, help="Will re-run controls when found.")
@click.option('-i', '--insecure', is_flag=True, help="Disable SSL certificate verification.")
def run_controls(config_file, profile, filter, batch, cooldown, max_controls, max_passes, execute, insecure):
    """ Streams controls matching the provided filter and re-runs them page by
        page if --execute is set, without enumerating the full result set first. """
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
    start_time = datetime.now()

    # Validate the profile and connection
    try:
        config = turbot.Config(config_file, profile)
        headers = {'Authorization': f'Basic {config.auth_token}'}
        endpoint_url = config.graphql_endpoint
    except KeyError:
        print(f"Error: The profile '{profile}' does not exist in the configuration file.")
        print("Please check your configuration file or specify a valid profile using the -p option.")
        return
    except requests.exceptions.RequestException as e:
        print(f"Error: Unable to connect to the endpoint. {e}")
        return
    except Exception as e:
        print(f"Error: Unable to load configuration or connect to the endpoint. {e}")
        return

    # Set up a requests session
    session = requests.Session()
    session.verify = not insecure

    if insecure:
        requests.packages.urllib3.disable_warnings()

    # The batch size doubles as the page size, unless the filter already sets one.
    if "limit:" in filter:
        page_filter = filter
    else:
        page_filter = f"{filter} limit:{batch}"

    print(f"\nUsing the filter: {filter}")

    # One cheap stats query gives the total without enumerating any items.
    try:
        data = graphql(session, endpoint_url, headers, TOTAL_QUERY, {'filter': filter})
        initial_total = data['controls']['metadata']['stats']['total']
    except RuntimeError as e:
        print(f"Error: {e}")
        print("Query failed. Please check the filter or query syntax and try again.")
        return

    print(f"Found {initial_total} matching controls.")

    if not execute:
        print("\n --execute flag not set. Exiting.")
        return

    # Controls already triggered (or skipped) this run. Reruns are asynchronous,
    # so a just-run control can still match the filter on the next page or pass;
    # this set makes sure each control is only triggered once.
    seen = set()
    triggered_controls = 0
    skipped_controls = 0
    pass_number = 0
    stop = False

    while not stop:
        pass_number += 1
        if max_passes != -1 and pass_number > max_passes:
            print(f"\nReached the maximum of {max_passes} passes. Stopping.")
            break

        paging = None
        fresh_this_pass = 0

        while not stop:
            try:
                data = graphql(session, endpoint_url, headers, PAGE_QUERY,
                               {'filter': page_filter, 'paging': paging})
            except RuntimeError as e:
                print(f"Error: {e}")
                print("Page query failed. Re-run the script to continue; already-run controls will fall out of the filter as they complete.")
                return

            page = data['controls']

            for control in page['items']:
                if control is None or 'turbot' not in control or 'id' not in control['turbot']:
                    print("Skipping a control due to missing required keys.")
                    skipped_controls += 1
                    continue

                control_id = control['turbot']['id']
                if control_id in seen:
                    continue
                seen.add(control_id)
                fresh_this_pass += 1

                try:
                    result = graphql(session, endpoint_url, headers, RUN_MUTATION,
                                     {'input': {'id': control_id}})
                    if result.get('runControl') is None:
                        print(f"Skipping control ID {control_id} due to missing mutation data.")
                        skipped_controls += 1
                        continue
                    process_id = result['runControl']['turbot']['id']
                    print(f'{{"controlId": "{control_id}", "processId": "{process_id}"}}')
                    triggered_controls += 1
                except RuntimeError as e:
                    print(f"Skipping control ID {control_id} due to {e}")
                    skipped_controls += 1
                    continue

                if max_controls != -1 and triggered_controls >= max_controls:
                    print(f"\nReached the maximum of {max_controls} controls. Stopping.")
                    stop = True
                    break

                # Batch and cooldown handling
                if triggered_controls % batch == 0:
                    print(f"Triggered {triggered_controls} of ~{initial_total} controls. "
                          f"Skipped {skipped_controls} so far.", end="")
                    if cooldown > 0:
                        print(f" Waiting for {cooldown} seconds before running the next batch...")
                        time.sleep(cooldown)
                    else:
                        print()

            paging = page['paging']['next']
            if not paging:
                break

        if stop:
            break

        if fresh_this_pass == 0:
            print(f"\nPass {pass_number} found no new controls. Filter drained.")
            break

        print(f"\nPass {pass_number} complete: {fresh_this_pass} new controls found. "
              f"Checking for controls missed while the result set shifted...")

    end_time = datetime.now()
    elapsed_time = (end_time - start_time).total_seconds()

    print("\nSummary:")
    print(f"Initial Matching Controls: {initial_total}")
    print(f"Total Controls Triggered: {triggered_controls}")
    print(f"Total Controls Skipped: {skipped_controls}")
    print(f"Total Passes: {pass_number}")
    print(f"Total Time Taken: {elapsed_time:.2f} seconds")


if __name__ == "__main__":
    try:
        run_controls()
    except Exception as e:
        print(e)
