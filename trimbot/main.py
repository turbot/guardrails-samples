import sys
import click
import logging
import os
from datetime import datetime
from trimbot_modules import Configuration, Session, Recipe, V3Api, ResourceServiceFactory, CheckAction, NoCheckAction


def configure_logging(trace):
    if trace:
        logFormatter = logging.Formatter("%(asctime)s [%(levelname)s] %(message)s (%(name)s)")
    else:
        logFormatter = logging.Formatter("%(asctime)s [%(levelname)s] %(message)s")

    today = datetime.now()

    timestamp = today.strftime("%Y%m%d%H%M%S")
    if not os.path.exists('./logs'):
        os.makedirs('./logs')

    fileHandler = logging.FileHandler(f"./logs/trimbot_{timestamp}.log")
    fileHandler.setFormatter(logFormatter)

    consoleHandler = logging.StreamHandler(sys.stdout)
    consoleHandler.setFormatter(logFormatter)

    logging.getLogger().setLevel(logging.INFO)
    logging.getLogger().addHandler(fileHandler)
    logging.getLogger().addHandler(consoleHandler)


def create_child_session(profile, workspace):
    workspace_profile = workspace.get_profile()
    if workspace_profile:
        profile = workspace_profile

    child_session = Session(profile, workspace.get_role_arn(), workspace.get_external_id())
    caller_account_id = child_session.get_connected_account_id()
    if workspace.get_account() != caller_account_id:
        raise RuntimeError(
            f'Connected account id {caller_account_id} differs from turbot expected account id {caller_account_id}')

    return child_session


def create_v3_api(configuration, workspace):
    configuration_host = configuration.get_turbot_host()
    configuration_access_key = configuration.get_turbot_access_key()
    configuration_secret_access_key = configuration.get_turbot_secret_access_key()
    configuration_verify_ssl = configuration.get_verify_ssl()

    workspace_host = workspace.get_turbot_host()
    workspace_access_key = workspace.get_turbot_access_key()
    workspace_secret_access_key = workspace.get_turbot_secret_access_key()
    workspace_verify_ssl = workspace.get_verify_ssl()

    host = workspace_host if workspace_host else configuration_host
    access_key = workspace_access_key if workspace_access_key else configuration_access_key
    secret_access_key = workspace_secret_access_key if workspace_secret_access_key else configuration_secret_access_key
    verify_ssl = workspace_verify_ssl if workspace_verify_ssl != None else configuration_verify_ssl

    v3_api = V3Api(
        host,
        access_key,
        secret_access_key,
        verify_ssl
    )

    return v3_api


def load_recipe(configuration, workspace):
    configuration_recipe = configuration.get_recipe()
    workspace_recipe = workspace.get_recipe()

    recipe_location = workspace_recipe if workspace_recipe else configuration_recipe
    recipe = Recipe(recipe_location)

    recipe.load()

    return recipe


def resolve_profile(configuration, workspace):
    configuration_profile = configuration.get_profile()
    workspace_profile = workspace.get_profile()

    return workspace_profile if workspace_profile else configuration_profile


@ click.command()
@ click.option('-f', '--config-file', type=click.File('r'), required=True, help='/path/to/a/configuration/file.yml')
@ click.option('-a', '--approve', is_flag=True, default=False, help='If set, destructive changes will be applied')
@ click.option('-t', '--trace', is_flag=True, default=False, help='Adds more detailed logging')
@ click.option('-c', '--check', is_flag=True, default=False, help='Runs action check only')
def cli(config_file, approve, trace, check):
    try:
        dry_run = not approve
        configure_logging(trace)
        logging.info(f'Started TrimBot')

        action = CheckAction() if check else NoCheckAction(dry_run)
        configuration = Configuration(config_file)

        for workspace in configuration.workspaces:
            try:
                account_id = workspace.get_turbot_account()
                cluster_id = workspace.get_turbot_cluster()

                logging.info(f"Processing account {account_id} for cluster {cluster_id}")
                profile = resolve_profile(configuration, workspace)
                v3_api = create_v3_api(configuration, workspace)

                child_session = create_child_session(profile, workspace)
                master_session = Session(profile)

                factory = ResourceServiceFactory(master_session, child_session, v3_api, account_id, cluster_id)

                recipe = load_recipe(configuration, workspace)
                for recipe_resource in recipe.resources:
                    service = factory.create_resource_service(recipe_resource)

                    if not action.should_process(recipe_resource["actions"]):
                        continue

                    if service.is_global_service():
                        logging.info(
                            f"Processing global resource named '{service.get_user_defined_name()}' for service {service.get_service_name()} and resource {service.get_resource_name()}")

                        action.run_action(service, child_session.get_default_region(), recipe_resource["actions"])

                        logging.info(
                            f"Completed - Processing global resource named '{service.get_user_defined_name()}' for service {service.get_service_name()} and resource {service.get_resource_name()}")

                    else:
                        logging.info(
                            f"Processing resource named '{service.get_user_defined_name()}' for service {service.get_service_name()} and resource {service.get_resource_name()}")

                        regions = child_session.get_regions()
                        for region in regions:
                            logging.info(f"Processing region {region}")

                            action.run_action(service, region, recipe_resource["actions"])

                        logging.info(
                            f"Completed - Processing resource named '{service.get_user_defined_name()}' for service {service.get_service_name()} and resource {service.get_resource_name()}")

                logging.info(f"Completed - Processing account {account_id} for cluster {cluster_id}")
            except Exception as e:
                logging.error(f'Ignoring workspace for account {workspace.get_account()}')
                logging.error(e)

        logging.info(f'TrimBot completed')
    except Exception as e:
        logging.error(f'Unexpected exception:')
        logging.error(e)


if __name__ == "__main__":
    cli()
