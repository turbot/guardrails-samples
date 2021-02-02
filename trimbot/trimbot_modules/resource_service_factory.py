from .codecommit_repository import CodeCommitRepositoryResourceService
from .ec2_keypair import Ec2KeyPairResourceService
from .sns_topic import SnsTopicResourceService
from .event_rule import EventsRuleResourceService
from .iam_user import IamUserResourceService
from .iam_role import IamRoleResourceService
from .iam_group import IamGroupResourceService
from .s3_bucket import S3BucketResourceService
from .iam_policy import IamPolicyResourceService
from .cloudformation_stack import CloudFormationStackResourceService
from .turbot_database import TurbotDatabaseResourceService
from .turbot_policies import TurbotPoliciesResourceService
from .turbot_account import TurbotAccountResourceService
from .cloudtrail_trial import CloudTrailTrailResourceService


class ResourceServiceFactory:
    def __init__(self, master_session, client_session, v3_api, turbot_account_id, turbot_cluster_id) -> None:
        self.client_map = self.create_resource_service_map()
        self.client_session = client_session
        self.master_session = master_session
        self.v3_api = v3_api
        self.turbot_account_id = turbot_account_id
        self.turbot_cluster_id = turbot_cluster_id
        self.turbot_account_urn = f"urn:turbot:{turbot_cluster_id}:{turbot_account_id}"
        super().__init__()

    def create_resource_service(self, recipe):
        key = f"{recipe['service']}_{recipe['resource']}"

        if key not in self.client_map:
            message = f"Resource factory unable to create a resource instance for service {recipe['service']} and resource {recipe['resource']}"
            raise RuntimeError(message)

        if key == "turbot_policies":
            return self.client_map[key](self.master_session, self.v3_api, recipe, self.turbot_account_id, self.turbot_account_urn)
        elif key == "turbot_account":
            return self.client_map[key](self.master_session, self.v3_api, recipe,  self.turbot_account_id)
        elif key == "codecommit_repository":
            return self.client_map[key](self.master_session, recipe,  self.turbot_account_id)
        elif key == "turbot_database":
            return self.client_map[key](self.master_session, recipe, self.turbot_account_urn)
        elif key == "s3_bucket" or key == "cloudformation_stack":
            return self.client_map[key](self.client_session, recipe, self.turbot_account_id)

        return self.client_map[key](self.client_session, recipe)

    def create_resource_service_map(self):
        return {
            "ec2_keypair": Ec2KeyPairResourceService,
            "sns_topic": SnsTopicResourceService,
            "events_rule": EventsRuleResourceService,
            "iam_user": IamUserResourceService,
            "iam_role": IamRoleResourceService,
            "iam_group": IamGroupResourceService,
            "s3_bucket": S3BucketResourceService,
            "iam_policy": IamPolicyResourceService,
            "cloudformation_stack": CloudFormationStackResourceService,
            "turbot_database": TurbotDatabaseResourceService,
            "turbot_policies": TurbotPoliciesResourceService,
            "codecommit_repository": CodeCommitRepositoryResourceService,
            "turbot_account": TurbotAccountResourceService,
            "cloudtrail_trail": CloudTrailTrailResourceService
        }
