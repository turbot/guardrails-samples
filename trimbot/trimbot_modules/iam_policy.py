from .resource_service import ResourceService
from .resource import Resource
import logging


class IamPolicy(Resource):
    def __init__(self, session, region, policy) -> None:
        self.policy = policy
        self.region = region
        self.logger = logging.getLogger(__name__)
        self.iam_client = session.create_client('iam', self.region)

        super().__init__(session)

    def details(self):
        return f'iam/policy {self.policy["PolicyName"]}'

    def delete(self, dry_run):
        response = self.iam_client.list_entities_for_policy(
            PolicyArn=self.policy["Arn"]
        )

        for policy_group in response["PolicyGroups"]:
            if not dry_run:
                self.iam_client.detach_group_policy(
                    GroupName=policy_group["GroupName"],
                    PolicyArn=self.policy["Arn"]
                )

                self.logger.info(
                    f"Detached group policy {policy_group['GroupName']} from policy {self.policy['PolicyName']}")
            else:
                self.logger.info(
                    f"Would detach group policy {policy_group['GroupName']} from policy {self.policy['PolicyName']}")

        for policy_users in response["PolicyUsers"]:
            if not dry_run:
                self.iam_client.detach_user_policy(
                    UserName=policy_users["UserName"],
                    PolicyArn=self.policy["Arn"]
                )

                self.logger.info(
                    f"Detached group policy {policy_users['UserName']} from policy {self.policy['PolicyName']}")
            else:
                self.logger.info(
                    f"Would detach group policy {policy_users['UserName']} from policy {self.policy['PolicyName']}")

        for policy_roles in response["PolicyRoles"]:
            if not dry_run:
                self.iam_client.detach_role_policy(
                    RoleName=policy_roles["RoleName"],
                    PolicyArn=self.policy["Arn"]
                )

                self.logger.info(
                    f"Detached group policy {policy_roles['RoleName']} from policy {self.policy['PolicyName']}")
            else:
                self.logger.info(
                    f"Would detach group policy {policy_roles['RoleName']} from policy {self.policy['PolicyName']}")

        response = self.iam_client.list_policy_versions(
            PolicyArn=self.policy["Arn"]
        )

        for version in response['Versions']:
            if not version['IsDefaultVersion']:
                if not dry_run:
                    response = self.iam_client.delete_policy_version(
                        PolicyArn=self.policy["Arn"],
                        VersionId=version['VersionId']
                    )
                    self.logger.info(
                        f"Deleting policy version {version['VersionId']} from policy {self.policy['PolicyName']}")
                else:
                    self.logger.info(
                        f"Would delete policy version {version['VersionId']} from policy {self.policy['PolicyName']}")

        if not dry_run:
            response = self.iam_client.delete_policy(
                PolicyArn=self.policy["Arn"]
            )

            self.logger.info(f"Deleted policy {self.policy['PolicyName']}")
        else:
            self.logger.info(f"Would delete policy {self.policy['PolicyName']}")


class IamPolicyResourceService(ResourceService):
    def __init__(self, session, recipe) -> None:
        super().__init__(session, recipe, "iam", "policy", True)

    def get_all(self, region):
        iam_client = self.session.create_client('iam', region)

        path_prefix = "/"
        for filter in self.recipe["filters"]:
            if filter["field"] == "PathPrefix":
                path_prefix = filter["value"]

        response = iam_client.list_policies(
            PathPrefix=path_prefix,
            Scope='Local',
            OnlyAttached=False
        )

        resources = []
        for policy in response["Policies"]:
            if policy["Path"] == path_prefix:
                resources.append(IamPolicy(self.session, region, policy))

        return resources
