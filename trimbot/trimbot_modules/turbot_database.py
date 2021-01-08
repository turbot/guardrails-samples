from .resource_service import ResourceService
from .resource import Resource
import logging


class TurbotDatabase(Resource):
    def __init__(self, session, account_urn) -> None:
        self.account_urn = account_urn
        self.dynamodb_client = session.create_client("dynamodb", session.get_default_region())
        self.sts_client = session.create_client("sts", session.get_default_region())
        self.logger = logging.getLogger(__name__)
        self.tables = self.get_active_tables()
        super().__init__(session)

    def delete_account(self, account_urn, dry_run=True):
        urn_parts = account_urn.split(':')
        cluster_id = urn_parts[2]
        account_id = urn_parts[-1]

        self.delete_item(
            'TurbotAccounts',
            {
                'id': {'S': account_id},
                'clusterId': {'S': cluster_id}
            },
            dry_run
        )

    def delete_directories(self, urn, dry_run=True):
        table_name = 'TurbotDirectories'
        search_urn = urn + ':'

        items = self.scan_table(
            table_name=table_name,
            filter_expression='begins_with ( urn , :resource_urn )',
            expression_values={':resource_urn': {'S': search_urn}}
        )
        for item in items:
            dry_run = False
            self.delete_item(
                table_name=table_name,
                key_info={'urn': item.get('urn')},
                dry_run=dry_run
            )

    def delete_directory_groups(self,  urn, dry_run=True):
        pass

    def delete_directory_users(self, urn, dry_run=True):
        table_name = 'TurbotDirectoryUsers'
        search_urn = urn + ':'

        items = self.scan_table(
            table_name=table_name,
            filter_expression='begins_with ( directoryUrn , :resource_urn )',
            expression_values={':resource_urn': {'S': search_urn}}
        )

        for item in items:
            self.dynamodb_client.delete_item(
                table_name=table_name,
                key_info={
                    'directoryUrn': item.get('directoryUrn'),
                    'id': item.get('id')
                },
                dry_run=dry_run
            )

    def delete_grants(self, urn, dry_run=True):
        table_name = 'TurbotGrants'

        grants = self.query_table(
            table_name=table_name,
            index_name='resourceUrn-index',
            key_expression='resourceUrn = :urn',
            expression_values={':urn': {'S': urn}}
        )

        for grant in grants:
            self.delete_item(
                table_name=table_name,
                key_info={'grantUrn': grant.get('grantUrn')},
                dry_run=dry_run
            )

    def delete_account_guardrails(self, urn, dry_run=True):
        table_name = 'TurbotGuardrails'
        index_name = 'accountUrn-alarmUrn-index'
        key_expression = 'accountUrn = :urn AND begins_with ( alarmUrn , :alarm_urn )'

        guardrails = self.query_table(
            table_name=table_name,
            index_name=index_name,
            key_expression=key_expression,
            expression_values={
                ':urn': {'S': urn},
                ':alarm_urn': {'S': 'urn'}
            }
        )

        for guardrail in guardrails:
            self.delete_item(
                table_name=table_name,
                key_info={
                    'resourceUrn': guardrail.get('resourceUrn'),
                    'alarmUrn': guardrail.get('alarmUrn')
                },
                dry_run=dry_run
            )

    def delete_account_monitors(self, urn, dry_run=True):
        table_name = 'TurbotMonitors'

        index_name = 'accountUrn-alarmUrn-index'
        key_expression = 'accountUrn = :urn AND begins_with ( alarmUrn , :alarm_urn )'
        monitors = self.query_table(
            table_name=table_name,
            index_name=index_name,
            key_expression=key_expression,
            expression_values={
                ':urn': {'S': urn},
                ':alarm_urn': {'S': 'urn'}
            }
        )

        for monitor in monitors:
            self.dynamodb_client.delete_item(
                table_name=table_name,
                key_info={
                    'resourceUrn': monitor.get('resourceUrn'),
                    'alarmUrn': monitor.get('alarmUrn')
                },
                dry_run=dry_run
            )

    def delete_option_settings(self, urn, dry_run=True):
        table_name = 'TurbotOptionSettings'
        search_urn = urn + ':'

        options = self.scan_table(
            table_name=table_name,
            filter_expression='begins_with ( resourceUrn , :resource_urn )',
            expression_values={':resource_urn': {'S': search_urn}}
        )

        for option in options:
            self.delete_item(
                table_name=table_name,
                key_info={
                    'resourceUrn': option.get('resourceUrn'),
                    'name': option.get('name')
                },
                dry_run=dry_run
            )

    def delete_package_sources(self, urn, dry_run=True):
        table_name = 'TurbotPackageSources'

        if table_name not in self.tables:
            return

        search_urn = urn + ':'

        items = self.scan_table(
            table_name=table_name,
            filter_expression='begins_with ( resourceUrn , :resource_urn )',
            expression_values={':resource_urn': {'S': search_urn}}
        )
        for item in items:
            self.delete_item(
                table_name=table_name,
                key_info={
                    'resourceUrn': item.get('resourceUrn'),
                    'id': item.get('name')
                },
                dry_run=dry_run
            )

    def delete_package_version_installations(self, urn, dry_run=True):
        table_name = 'TurbotPackageVersionInstallations'

        if table_name not in self.tables:
            return

        search_urn = urn + ':'

        items = self.scan_table(
            table_name=table_name,
            filter_expression='begins_with ( resourceUrn , :resource_urn )',
            expression_values={':resource_urn': {'S': search_urn}}
        )

        for item in items:
            self.delete_item(
                table_name=table_name,
                key_info={
                    'resourceUrn': item.get('resourceUrn'),
                    'id': item.get('name')
                },
                dry_run=dry_run
            )

    def delete_playbooks(self, urn, dry_run=True):
        table_name = 'TurbotPlaybooks'
        search_urn = urn + ':'

        items = self.scan_table(
            table_name=table_name,
            filter_expression='begins_with ( resourceUrn , :resource_urn )',
            expression_values={':resource_urn': {'S': search_urn}}
        )

        for item in items:
            self.delete_item(
                table_name=table_name,
                key_info={
                    'resourceUrn': item.get('resourceUrn'),
                    'playbookId': item.get('playbookId')
                },
                dry_run=dry_run
            )

    def delete_profiles(self, urn, dry_run=True):
        table_name = 'TurbotProfiles'
        search_urn = urn + ':'

        items = self.scan_table(
            table_name=table_name,
            filter_expression='begins_with ( urn , :resource_urn )',
            expression_values={':resource_urn': {'S': search_urn}}
        )

        for item in items:
            self.delete_item(
                table_name=table_name,
                key_info={
                    'urn': item.get('urn')
                },
                dry_run=dry_run
            )

    def delete_profile_service_logins(self, urn, dry_run=True):
        table_name = 'TurbotProfileServiceLogins'
        search_urn = urn + ':'

        items = self.scan_table(
            table_name=table_name,
            filter_expression='begins_with ( profileUrn , :resource_urn )',
            expression_values={':resource_urn': {'S': search_urn}}
        )

        for item in items:
            self.delete_item(
                table_name=table_name,
                key_info={'id': item.get('id')},
                dry_run=dry_run
            )

    def delete_resource_groups(self, urn, dry_run=True):
        table_name = 'TurbotResourceGroups'
        search_urn = urn + ':'

        items = self.scan_table(
            table_name=table_name,
            filter_expression='begins_with ( resourceUrn , :resource_urn )',
            expression_values={':resource_urn': {'S': search_urn}}
        )

        for item in items:
            result = self.delete_item(
                table_name=table_name,
                key_info={
                    'resourceUrn': item.get('resourceUrn'),
                    'id': item.get('id')
                },
                dry_run=dry_run
            )

    def delete_resource_metadata(self, urn, dry_run=True):
        table_name = 'TurbotResourceMetadata'
        search_urn = urn + ':'

        items = self.scan_table(
            table_name=table_name,
            filter_expression='begins_with ( resourceUrn , :resource_urn )',
            expression_values={':resource_urn': {'S': search_urn}}
        )

        for item in items:
            result = self.delete_item(
                table_name=table_name,
                key_info={
                    'resourceUrn': item.get('resourceUrn'),
                    'metadataName': item.get('metadataName')
                },
                dry_run=dry_run
            )

    def delete_resource_secrets(self, urn, dry_run=True):
        table_name = 'TurbotResourceSecrets'
        search_urn = urn + ':'

        items = self.scan_table(
            table_name=table_name,
            filter_expression='begins_with ( resourceUrn , :resource_urn )',
            expression_values={':resource_urn': {'S': search_urn}}
        )

        for item in items:
            self.delete_item(
                table_name=table_name,
                key_info={
                    'resourceUrn': item.get('resourceUrn'),
                    'secretName': item.get('secretName')
                },
                dry_run=dry_run
            )

    def delete_ssh_keys(self, urn, dry_run=True):
        table_name = 'TurbotSshKeys'
        search_urn = urn + ':'

        items = self.scan_table(
            table_name=table_name,
            filter_expression='begins_with ( resourceUrn , :resource_urn )',
            expression_values={':resource_urn': {'S': search_urn}}
        )

        for item in items:
            self.delete_item(
                table_name=table_name,
                key_info={
                    'resourceUrn': item.get('resourceUrn'),
                    'fingerprint': item.get('fingerprint')
                },
                dry_run=dry_run
            )

    def delete_account_stacks(self, urn, resource_type='account', dry_run=True):
        table_name = 'TurbotStacks'

        index_name = 'accountUrn-alarmUrn-index'
        key_expression = 'accountUrn = :urn AND begins_with ( alarmUrn , :alarm_urn )'

        items = self.query_table(
            table_name=table_name,
            index_name=index_name,
            key_expression=key_expression,
            expression_values={
                ':urn': {'S': urn},
                ':alarm_urn': {'S': 'urn'}
            }
        )

        for item in items:
            self.delete_item(
                table_name=table_name,
                key_info={
                    'resourceUrn': item.get('resourceUrn'),
                    'alarmUrn': item.get('alarmUrn')
                },
                dry_run=dry_run
            )

    def delete_user_access_keys(self, urn, dry_run=True):
        table_name = 'TurbotUserAccessKeys'
        search_urn = urn + ':'

        items = self.scan_table(
            table_name=table_name,
            filter_expression='begins_with ( userUrn , :resource_urn )',
            expression_values={':resource_urn': {'S': search_urn}}
        )

        for item in items:
            self.delete_item(
                table_name=table_name,
                key_info={'accessKeyId': item.get('accessKeyId')},
                dry_run=dry_run
            )

    def delete_item(self, table_name, key_info, dry_run=True):
        if not dry_run:
            try:
                self.dynamodb_client.delete_item(
                    TableName=table_name,
                    Key=key_info
                )
                self.logger.info(f'Deleted {key_info} from table {table_name}')
            except Exception as e:
                if e.response["Error"]["Code"] == "ResourceNotFoundException":
                    self.logger.error(f'Table not found {table_name}')
                raise
        else:
            self.logger.info(f'Would delete {key_info} from table {table_name}')

    def scan_table(self, table_name, filter_expression, expression_values):
        try:
            results = []
            paginator = self.dynamodb_client.get_paginator('scan')
            response_iterator = paginator.paginate(
                TableName=table_name,
                FilterExpression=filter_expression,
                ExpressionAttributeValues=expression_values
            )
            for response in response_iterator:
                results += response.get('Items')
            return results
        except Exception as e:
            if e.response["Error"]["Code"] == "ResourceNotFoundException":
                self.logger.warn(f'Table not found {table_name}')
            raise

    def query_table(self, table_name, index_name, key_expression, expression_values):
        try:
            results = []
            paginator = self.dynamodb_client.get_paginator('query')
            response_iterator = paginator.paginate(
                TableName=table_name,
                IndexName=index_name,
                KeyConditionExpression=key_expression,
                ExpressionAttributeValues=expression_values
            )
            for response in response_iterator:
                results += response.get('Items')
            return results
        except Exception as e:
            if e.response["Error"]["Code"] == "ResourceNotFoundException":
                self.logger.warn(f'Table not found {table_name}')
            raise

    def get_active_tables(self):
        return self.dynamodb_client.list_tables()["TableNames"]

    def details(self):
        return f'turbot/database {self.account_urn}'

    def delete(self, dry_run):
        self.delete_account(self.account_urn, dry_run)
        self.delete_directories(self.account_urn, dry_run)
        self.delete_directory_users(self.account_urn, dry_run)
        self.delete_grants(self.account_urn, dry_run)
        self.delete_account_guardrails(self.account_urn, dry_run)
        self.delete_account_monitors(self.account_urn, dry_run)
        self.delete_option_settings(self.account_urn, dry_run)
        self.delete_package_sources(self.account_urn, dry_run)
        self.delete_package_version_installations(self.account_urn, dry_run)
        self.delete_playbooks(self.account_urn, dry_run)
        self.delete_profiles(self.account_urn, dry_run)
        self.delete_profile_service_logins(self.account_urn, dry_run)
        self.delete_resource_groups(self.account_urn, dry_run)
        self.delete_resource_metadata(self.account_urn, dry_run)
        self.delete_resource_secrets(self.account_urn, dry_run)
        self.delete_ssh_keys(self.account_urn, dry_run)
        self.delete_account_stacks(self.account_urn, dry_run)
        self.delete_user_access_keys(self.account_urn, dry_run)


class TurbotDatabaseResourceService(ResourceService):
    def __init__(self, session, recipe, account_urn) -> None:
        self.account_urn = account_urn
        super().__init__(session, recipe, "turbot", "database", True)

    def get_all(self, region):
        return [TurbotDatabase(self.session, self.account_urn)]
