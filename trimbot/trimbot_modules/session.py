import boto3
import logging
from .resource_factory import ResourceFactory


class Session:
    def __init__(self, workspace, profile_name, logger=logging.getLogger("Trimbot")) -> None:
        self.logger = logger

        self.managed_account = True if 'roleArn' in workspace else False
        self.session = self.create_session(workspace, profile_name)

        super().__init__()

    def create_resource_factory(self):
        return ResourceFactory(self.session)

    def create_session(self, workspace, profile_name):
        account_id = workspace['account']
        try:
            session = boto3.Session(profile_name=profile_name)

            if self.managed_account:
                # What about ExternalId?

                sts_client = session.client('sts')
                role_arn = workspace['roleArn']

                response = sts_client.assume_role(
                    RoleArn=role_arn,
                    RoleSessionName=f'trimbot_{account_id}',
                    DurationSeconds=900,
                    ExternalId='magic'
                )

                session = boto3.Session(
                    aws_access_key_id=response['Credentials']['AccessKeyId'],
                    aws_secret_access_key=response['Credentials']['SecretAccessKey'],
                    aws_session_token=response['Credentials']['SessionToken'],
                )

            sts_client = session.client('sts')
            caller_account_id = sts_client.get_caller_identity()['Account']

            if account_id != caller_account_id:
                raise RuntimeError(f'Caller identity {caller_account_id} differs from expected account id {account_id}')

            self.logger.info(f'Created connection to account: {account_id}')

            return session
        except Exception:
            self.logger.error(f'Unable to create session for account id: {account_id}')
            raise
