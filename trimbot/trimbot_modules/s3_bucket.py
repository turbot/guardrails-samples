import re
from .resource_service import ResourceService
from .resource import Resource
import logging
import botocore


class S3Bucket(Resource):
    def __init__(self, session, region, bucket) -> None:
        self.bucket = bucket
        self.region = region
        self.logger = logging.getLogger(__name__)
        self.s3_client = session.create_client('s3', self.region)

        super().__init__(session)

    def details(self):
        return f's3/bucket {self.bucket["Name"]}'

    def check(self):
        response = self.s3_client.list_objects_v2(
            Bucket=self.bucket['Name'],
            MaxKeys=1
        )
        empty = "Contents" not in response
        if empty:
            self.logger.info(f"Bucket {self.bucket['Name']} is empty and can be deleted")
        else:
            self.logger.info(f"Bucket {self.bucket['Name']} is NOT empty and cannot be deleted")

        return super().check()
    # TODO Write delete

    def disable(self, dry_run):
        if not dry_run:
            self.s3_client.put_bucket_versioning(
                Bucket=self.bucket['Name'],
                VersioningConfiguration={'Status': 'Suspended'}
            )
            self.logger.info(f"Disabled bucket versioning for bucket {self.bucket['Name']}")

            self.s3_client.put_bucket_logging(
                Bucket=self.bucket['Name'],
                BucketLoggingStatus={}
            )
            self.logger.info(f"Disabled bucket logging for bucket {self.bucket['Name']}")

            self.s3_client.put_bucket_lifecycle_configuration(
                Bucket=self.bucket['Name'],
                LifecycleConfiguration={
                    'Rules': [
                        {
                            'Expiration': {'Days': 1},
                            'Prefix': '',
                            'ID': 'Turbot Account Clean - Delete All Objects',
                            'Status': 'Enabled',
                            'NoncurrentVersionExpiration': {'NoncurrentDays': 1},
                            'AbortIncompleteMultipartUpload': {'DaysAfterInitiation': 1}
                        }
                    ]
                }
            )
            self.logger.info(f"Set bucket lifecycle to clear bucket {self.bucket['Name']}")
        else:
            self.logger.info(f"Would disable bucket versioning for bucket {self.bucket['Name']}")
            self.logger.info(f"Would disable bucket logging for bucket {self.bucket['Name']}")
            self.logger.info(f"Would set bucket lifecycle to clear bucket {self.bucket['Name']}")


def create_region_key(region):
    location_map = {
        "north": "no",
        "northeast": "ne",
        "northwest": "nw",
        "south": "so",
        "southeast": "se",
        "southwest": "sw",
        "east": "ea",
        "west": "we",
        "central": "ce"
    }
    region_parts = region.split("-")

    return f"{region_parts[0][:2]}{location_map[region_parts[1]]}{region_parts[2]}"


class S3BucketResourceService(ResourceService):
    def __init__(self, session, recipe, account_id) -> None:
        self.account_id = account_id
        super().__init__(session, recipe, "s3", "bucket", True)

    def get_all(self, region):
        s3_client = self.session.create_client('s3', region)
        response = s3_client.list_buckets()

        regions = self.session.get_regions()

        region_keys_array = [create_region_key(region) for region in regions]
        region_keys = '|'.join(region_keys_array)

        regex = f"^{self.account_id}-({region_keys})-[a-zA-Z0-9]{{12,13}}$"

        resources = []
        for bucket in response["Buckets"]:
            if re.match(regex, bucket["Name"]):
                try:
                    # TODO: Found a race condition, if we delete the CloudFormation stacks, then the tags are removed
                    #       from the buckets and can no longer be used as an identifier
                    #       Could be resolved with an action that tags the resource
                    #
                    # bucket_name = bucket["Name"]
                    # response = s3_client.get_bucket_tagging(Bucket=bucket_name)
                    #
                    # for tag in response["TagSet"]:
                    #     if tag["Key"] == "aws:cloudformation:stack-id" and self.account_id in tag["Value"]:
                    #         resources.append(S3Bucket(self.session, region, bucket))
                    #         break
                    resources.append(S3Bucket(self.session, region, bucket))
                except botocore.exceptions.ClientError as e:
                    if e.response['Error']['Code'] != 'NoSuchTagSet':
                        raise

        return resources
