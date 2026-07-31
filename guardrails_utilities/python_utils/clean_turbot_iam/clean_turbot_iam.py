import json
import os
import subprocess

import click
import turbot

# Managed policies to remove, as (path, name). Path must match the policy ARN.
TARGET_POLICIES = [
    ("/", "turbot_config_policy"),
    ("/turbot/", "turbot_lockdown"),
    ("/turbot/", "turbot_deny"),
]

TARGET_ROLES = [
    "turbot_config",
    "turbot_vpc_flow_logging",
]

ACCOUNTS_QUERY = '''
  query ListAccounts($filter: [String!]!, $paging: String) {
    resources(filter: $filter, paging: $paging) {
      items {
        data
        metadata
        trunk { title }
      }
      paging {
        next
      }
    }
  }
'''


def run_aws(args, env):
    """ Runs an aws cli command, returns (ok, parsed json or error string). """
    cmd = ["aws"] + args + ["--output", "json"]
    result = subprocess.run(cmd, capture_output=True, text=True, env=env)
    if result.returncode != 0:
        return False, result.stderr.strip()
    if result.stdout.strip():
        return True, json.loads(result.stdout)
    return True, {}


def graphql(config, query, variables):
    import requests
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    r = requests.post(
        config.graphql_endpoint,
        headers=headers,
        json={'query': query, 'variables': variables}
    )
    r.raise_for_status()
    result = r.json()
    if "errors" in result:
        raise RuntimeError(json.dumps(result['errors'], indent=2))
    return result['data']


def get_accounts(config):
    accounts = []
    paging = None
    filter = "resourceTypeId:tmod:@turbot/aws#/resource/types/account resourceTypeLevel:self limit:300"

    while True:
        data = graphql(config, ACCOUNTS_QUERY, {'filter': [filter], 'paging': paging})
        for item in data['resources']['items']:
            account_id = item['data'].get('Id') or \
                item.get('metadata', {}).get('aws', {}).get('accountId')
            if account_id:
                accounts.append({'id': account_id, 'title': item['trunk']['title']})
        if not data['resources']['paging']['next']:
            break
        paging = data['resources']['paging']['next']

    return accounts


def assume_role(account_id, role_name, external_id, partition, base_env):
    role_arn = "arn:{}:iam::{}:role/{}".format(partition, account_id, role_name)
    cmd = [
        "sts", "assume-role",
        "--role-arn", role_arn,
        "--role-session-name", "clean-turbot-iam"
    ]
    if external_id:
        cmd += ["--external-id", external_id]
    ok, result = run_aws(cmd, base_env)

    if not ok:
        return None, result

    creds = result['Credentials']
    env = dict(base_env)
    env.pop('AWS_PROFILE', None)
    env['AWS_ACCESS_KEY_ID'] = creds['AccessKeyId']
    env['AWS_SECRET_ACCESS_KEY'] = creds['SecretAccessKey']
    env['AWS_SESSION_TOKEN'] = creds['SessionToken']
    return env, None


def clean_policy(policy_arn, env, execute):
    ok, result = run_aws(["iam", "get-policy", "--policy-arn", policy_arn], env)
    if not ok:
        if "NoSuchEntity" in result:
            print("    policy not found, skipping: {}".format(policy_arn))
            return True
        print("    ERROR get-policy {}: {}".format(policy_arn, result))
        return False

    print("    found policy: {}".format(policy_arn))

    # Refuse to touch policies in use as a permissions boundary.
    ok, boundary = run_aws([
        "iam", "list-entities-for-policy", "--policy-arn", policy_arn,
        "--policy-usage-filter", "PermissionsBoundary"
    ], env)
    if ok and (boundary.get('PolicyRoles') or boundary.get('PolicyUsers')):
        print("    WARNING: policy is used as a permissions boundary, skipping delete: {}".format(policy_arn))
        return False

    ok, entities = run_aws([
        "iam", "list-entities-for-policy", "--policy-arn", policy_arn,
        "--policy-usage-filter", "PermissionsPolicy"
    ], env)
    if not ok:
        print("    ERROR list-entities-for-policy {}: {}".format(policy_arn, entities))
        return False

    detachments = [
        ("detach-role-policy", "--role-name", r['RoleName'])
        for r in entities.get('PolicyRoles', [])
    ] + [
        ("detach-user-policy", "--user-name", u['UserName'])
        for u in entities.get('PolicyUsers', [])
    ] + [
        ("detach-group-policy", "--group-name", g['GroupName'])
        for g in entities.get('PolicyGroups', [])
    ]

    for action, flag, name in detachments:
        if execute:
            ok, result = run_aws(["iam", action, flag, name, "--policy-arn", policy_arn], env)
            if not ok:
                print("    ERROR {} {}: {}".format(action, name, result))
                return False
            print("    detached from {}".format(name))
        else:
            print("    would detach from {}".format(name))

    # Non-default versions must be deleted before the policy itself.
    ok, versions = run_aws(["iam", "list-policy-versions", "--policy-arn", policy_arn], env)
    if not ok:
        print("    ERROR list-policy-versions {}: {}".format(policy_arn, versions))
        return False

    for version in versions.get('Versions', []):
        if version['IsDefaultVersion']:
            continue
        if execute:
            ok, result = run_aws([
                "iam", "delete-policy-version", "--policy-arn", policy_arn,
                "--version-id", version['VersionId']
            ], env)
            if not ok:
                print("    ERROR delete-policy-version {}: {}".format(version['VersionId'], result))
                return False
        else:
            print("    would delete policy version {}".format(version['VersionId']))

    if execute:
        ok, result = run_aws(["iam", "delete-policy", "--policy-arn", policy_arn], env)
        if not ok:
            print("    ERROR delete-policy {}: {}".format(policy_arn, result))
            return False
        print("    deleted policy {}".format(policy_arn))
    else:
        print("    would delete policy {}".format(policy_arn))

    return True


def clean_role(role_name, env, execute):
    ok, result = run_aws(["iam", "get-role", "--role-name", role_name], env)
    if not ok:
        if "NoSuchEntity" in result:
            print("    role not found, skipping: {}".format(role_name))
            return True
        print("    ERROR get-role {}: {}".format(role_name, result))
        return False

    print("    found role: {}".format(role_name))

    ok, attached = run_aws(["iam", "list-attached-role-policies", "--role-name", role_name], env)
    if not ok:
        print("    ERROR list-attached-role-policies: {}".format(attached))
        return False

    for policy in attached.get('AttachedPolicies', []):
        if execute:
            ok, result = run_aws([
                "iam", "detach-role-policy", "--role-name", role_name,
                "--policy-arn", policy['PolicyArn']
            ], env)
            if not ok:
                print("    ERROR detach-role-policy {}: {}".format(policy['PolicyArn'], result))
                return False
            print("    detached {}".format(policy['PolicyArn']))
        else:
            print("    would detach {}".format(policy['PolicyArn']))

    ok, inline = run_aws(["iam", "list-role-policies", "--role-name", role_name], env)
    if not ok:
        print("    ERROR list-role-policies: {}".format(inline))
        return False

    for policy_name in inline.get('PolicyNames', []):
        if execute:
            ok, result = run_aws([
                "iam", "delete-role-policy", "--role-name", role_name,
                "--policy-name", policy_name
            ], env)
            if not ok:
                print("    ERROR delete-role-policy {}: {}".format(policy_name, result))
                return False
            print("    deleted inline policy {}".format(policy_name))
        else:
            print("    would delete inline policy {}".format(policy_name))

    ok, profiles = run_aws(["iam", "list-instance-profiles-for-role", "--role-name", role_name], env)
    if not ok:
        print("    ERROR list-instance-profiles-for-role: {}".format(profiles))
        return False

    for profile in profiles.get('InstanceProfiles', []):
        if execute:
            ok, result = run_aws([
                "iam", "remove-role-from-instance-profile",
                "--instance-profile-name", profile['InstanceProfileName'],
                "--role-name", role_name
            ], env)
            if not ok:
                print("    ERROR remove-role-from-instance-profile {}: {}".format(
                    profile['InstanceProfileName'], result))
                return False
            print("    removed from instance profile {}".format(profile['InstanceProfileName']))
        else:
            print("    would remove from instance profile {}".format(profile['InstanceProfileName']))

    if execute:
        ok, result = run_aws(["iam", "delete-role", "--role-name", role_name], env)
        if not ok:
            print("    ERROR delete-role {}: {}".format(role_name, result))
            return False
        print("    deleted role {}".format(role_name))
    else:
        print("    would delete role {}".format(role_name))

    return True


@click.command()
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('-c', '--config-file', default=None, help="[String] Path to custom Turbot config file.")
@click.option('-r', '--role-name', default="vaec/turbot/core/c-vaec-turbot", show_default=True, help="[String] Path and name of the role to assume in each account.")
@click.option('--external-id', default="turbot", show_default=True, help="[String] External id for the assume-role call. Pass an empty string to omit.")
@click.option('-a', '--account', multiple=True, help="[String] Limit run to specific account id(s). May be repeated.")
@click.option('--region', default="us-east-1", show_default=True, help="[String] AWS region for cli calls.")
@click.option('-e', '--execute', is_flag=True, help="Apply changes. Without this flag the script only reports what it would do.")
@click.option('--check-access', is_flag=True, help="Only test role assumption in each account and report failures. Makes no changes, takes precedence over --execute.")
def clean(profile, config_file, role_name, external_id, account, region, execute, check_access):
    config = turbot.Config(config_file, profile)

    base_env = dict(os.environ)
    if region:
        base_env['AWS_DEFAULT_REGION'] = region

    ok, identity = run_aws(["sts", "get-caller-identity"], base_env)
    if not ok:
        print("Failed to get caller identity, check AWS credentials: {}".format(identity))
        exit(1)
    partition = identity['Arn'].split(":")[1]
    print("Running as {} (partition: {})".format(identity['Arn'], partition))

    if check_access:
        print("\nCHECK ACCESS: only testing role assumption, no changes will be made.\n")
    elif not execute:
        print("\nDRY RUN: no changes will be made, use --execute to apply.\n")

    print("Fetching accounts from {} ...".format(config.workspace))
    accounts = get_accounts(config)
    if account:
        accounts = [a for a in accounts if a['id'] in account]
    print("Found {} accounts to process\n".format(len(accounts)))

    failed = []
    denied = []
    for acct in accounts:
        print("*****************************")
        print("* {} ({})".format(acct['title'], acct['id']))
        print("*****************************")

        env, error = assume_role(acct['id'], role_name, external_id, partition, base_env)
        if not env:
            print("    ERROR assuming role: {}".format(error))
            failed.append(acct['id'])
            denied.append((acct['id'], acct['title'], error))
            print()
            continue

        if check_access:
            print("    ok")
            print()
            continue

        acct_ok = True
        for path, name in TARGET_POLICIES:
            policy_arn = "arn:{}:iam::{}:policy{}{}".format(partition, acct['id'], path, name)
            if not clean_policy(policy_arn, env, execute):
                acct_ok = False

        for role in TARGET_ROLES:
            if not clean_role(role, env, execute):
                acct_ok = False

        if not acct_ok:
            failed.append(acct['id'])
        print()

    if denied:
        with open("access_err.log", "w") as f:
            for account_id, title, error in denied:
                f.write("{}  {}\n    {}\n".format(account_id, title, error))
        print("Wrote {} role assumption failures to access_err.log".format(len(denied)))

    if check_access:
        print("Checked {} accounts, {} failed role assumption".format(len(accounts), len(denied)))
        for account_id, title, error in denied:
            print("{}  {}".format(account_id, title))
            print("    {}".format(error))
        if denied:
            exit(1)
        return

    print("Processed {} accounts, {} with errors".format(len(accounts), len(failed)))
    if failed:
        print("Accounts with errors: {}".format(", ".join(failed)))
        exit(1)


if __name__ == '__main__':
    clean()
