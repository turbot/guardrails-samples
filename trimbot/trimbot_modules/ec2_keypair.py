from .resource_service import ResourceService
from .resource import Resource
import logging


class Ec2KeyPair(Resource):
    def __init__(self, session, region, key_pair) -> None:
        self.key_pair = key_pair
        self.region = region
        self.logger = logging.getLogger(__name__)

        super().__init__(session)

    def details(self):
        return f'ec2/keypair {self.key_pair["KeyName"]}'

    def delete(self, dry_run):
        ec2_client = self.session.create_client('ec2', self.region)

        if not dry_run:
            ec2_client.delete_key_pair(
                KeyPairId=self.key_pair["KeyPairId"],
            )

            self.logger.info(f"Removed keypair {self.key_pair['KeyName']}")
        else:
            self.logger.info(f"Would remove keypair {self.key_pair['KeyName']}")


class Ec2KeyPairResourceService(ResourceService):
    def __init__(self, session, recipe) -> None:
        super().__init__(session, recipe, "ec2", "keypair")

    def get_all(self, region):
        ec2_client = self.session.create_client('ec2', region)

        resources = []
        for filter in self.recipe["filters"]:
            if filter["field"] == "KeyNames":
                try:
                    key_name = filter["value"]

                    response = ec2_client.describe_key_pairs(KeyNames=[key_name])
                    for key_pair in response["KeyPairs"]:
                        resources.append(Ec2KeyPair(self.session, region, key_pair))

                except Exception as e:
                    if e.response["Error"]["Code"] != "InvalidKeyPair.NotFound":
                        raise

        return resources
