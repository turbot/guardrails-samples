import boto3
import logging


class Session:
    def __init__(self, profile_name, role_arn="", externalId="") -> None:
        self.logger = logging.getLogger(__name__)
        self.session = self.create_session(role_arn, externalId, profile_name)

        super().__init__()

    def get_regions(self):
        ec2_client = self.create_client("ec2", self.get_default_region())

        response = ec2_client.describe_regions(
            Filters=[
                {
                    "Name": "opt-in-status",
                    "Values": ["opt-in-not-required", "opted-in"]
                }
            ]
        )

        return [region["RegionName"] for region in response["Regions"]]

    def get_default_region(self):
        return self.session.region_name if self.session.region_name else "us-east-1"

    def create_client(self, service, region):
        return self.session.client(service, region)

    def get_connected_account_id(self):
        sts_client = self.session.client('sts')
        return sts_client.get_caller_identity()['Account']

    def create_session(self, role_arn, externalId, profile_name):
        session = None
        try:
            session = boto3.Session(profile_name=profile_name)
            self.logger.info(f'Created connection to profile: {profile_name}')
        except Exception:
            self.logger.error(f'Unable to create connection to profile: {profile_name}')
            raise

        if not role_arn:
            return session

        aws_account_id = role_arn.split(":")[4]
        try:
            sts_client = session.client('sts')
            if externalId:
                response = sts_client.assume_role(
                    RoleArn=role_arn,
                    RoleSessionName=f'trimbot_{aws_account_id}',
                    DurationSeconds=900,
                    ExternalId=externalId
                )
            else:
                response = sts_client.assume_role(
                    RoleArn=role_arn,
                    RoleSessionName=f'trimbot_{aws_account_id}',
                    DurationSeconds=900,
                )

            session = boto3.Session(
                aws_access_key_id=response['Credentials']['AccessKeyId'],
                aws_secret_access_key=response['Credentials']['SecretAccessKey'],
                aws_session_token=response['Credentials']['SessionToken'],
            )

            self.logger.info(f'Created connection to account: {aws_account_id}')

            return session
        except Exception:
            self.logger.error(f'Unable to create session for account id: {aws_account_id}')
            raise
