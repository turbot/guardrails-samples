import click
import logging
from trimbot_modules import Configuration, Session, load_recipe


def clean_workspaces(workspaces, profile, dry_run):
    for workspace in workspaces:
        try:
            session = Session(workspace, profile)
            factory = session.create_resource_factory()
            recipe = load_recipe(session.managed_account)

            # for resource in recipe.resources:
            #     print(resource)
        except Exception as e:
            logging.error(f'Ignoring workspace for account {workspace["account"]}')
            logging.error(e)


@click.command()
@click.option('-c', '--config-file', type=click.File('r'), required=True, help='/path/to/a/configuration/file.yml')
@click.option('--dryrun', is_flag=True, help='If set, do not make destructive changes')
@click.option('-p', '--profile', type=str, default='default', help='If using an AWS profile other than the default profile')
def cli(config_file, dryrun, profile):
    print(__file__)

    env = Configuration(config_file)

    clean_workspaces(env.workspaces, profile, dryrun)


if __name__ == "__main__":
    cli()
