import turbot
import click
import requests
import sys

def simple_query():
    """ Queries 20 random resources and prints their title """

    config = turbot.Config(None, None)
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    endpoint = config.graphql_endpoint

    query = '''
      {
        resources {
          items {
            title
          }
        }
      }
    '''

    result = run_query(endpoint, headers, query, variables)

    if "errors" in result:
        for error in result['errors']:
            print(error)
            break

    for item in result['data']['resources']['items']:
        print("Title: {}".format(item["title"]))


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
    if (sys.version_info > (3, 6)):
        try:
            simple_query()
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
