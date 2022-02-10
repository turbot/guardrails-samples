from .resource_service import ResourceService
from .resource import Resource
import logging


class IamPolicy(Resource):
    def __init__(self, session, region, policy) -> None:
        self.__policy_arn = policy["Arn"]
        self.__policy_name = policy["PolicyName"]
        self.__logger = logging.getLogger(__name__)
        self.__iam_client = session.create_client('iam', region)

        super().__init__(session)

    def details(self):
        return f'iam/policy {self.policy_name}'

    @property
    def iam_client(self):
        return self.__iam_client

    @property
    def logger(self) -> logging.Logger:
        return self.__logger

    @property
    def policy_name(self) -> str:
        return self.__policy_name

    @property
    def policy_arn(self) -> str:
        return self.__policy_arn

    def delete(self, dry_run):
        policy_group_names = []
        policy_user_names = []
        policy_role_names = []

        complete = False
        marker = None

        logging.info(self.policy_arn)
        logging.info(self.policy_name)
        while not complete:
            response = None
            if marker:
                response = self.iam_client.list_entities_for_policy(
                    PolicyArn=self.policy_arn,
                    Marker=marker,
                )
            else:
                response = self.iam_client.list_entities_for_policy(
                    PolicyArn=self.policy_arn,
                )

            if "Marker" in response:
                marker = response["Marker"]
            else:
                complete = True

            for policy_group in response["PolicyGroups"]:
                policy_group_names.append(policy_group["GroupName"])

            for policy_users in response["PolicyUsers"]:
                policy_user_names.append(policy_users["UserName"])

            for policy_roles in response["PolicyRoles"]:
                policy_role_names.append(policy_roles["RoleName"])

        policy_version_ids = []
        complete = False
        marker = None
        while not complete:
            if marker:
                response = self.iam_client.list_policy_versions(
                    PolicyArn=self.policy_arn,
                    Marker=marker
                )
            else:
                response = self.iam_client.list_policy_versions(
                    PolicyArn=self.policy_arn,
                )

            if "Marker" in response:
                marker = response["Marker"]
            else:
                complete = True

            for version in response['Versions']:
                if not version['IsDefaultVersion']:
                    policy_version_ids.append(version['VersionId'])

        for group_name in policy_group_names:
            self.__detach_group_policy(group_name, dry_run)

        for user_name in policy_user_names:
            self.__detach_user_policy(user_name, dry_run)

        for role_name in policy_role_names:
            self.__detach_role_policy(role_name, dry_run)

        for version_id in policy_version_ids:
            self.__delete_policy_version(version_id, dry_run)

        self.__delete_policy(dry_run)

    def __detach_group_policy(self, policy_group_name: str, dry_run: bool) -> None:
        if not dry_run:
            self.iam_client.detach_group_policy(
                GroupName=policy_group_name,
                PolicyArn=self.policy_arn
            )

            self.logger.info(
                f"Detached policy {self.policy_name} from group policy {policy_group_name}")
        else:
            self.logger.info(
                f"Would detach policy {self.policy_name} from group policy {policy_group_name}")

    def __delete_policy(self, dry_run: bool) -> None:
        if not dry_run:
            self.iam_client.delete_policy(
                PolicyArn=self.policy_arn
            )

            self.logger.info(f"Deleted policy {self.policy_name}")
        else:
            self.logger.info(f"Would delete policy {self.policy_name}")

    def __detach_user_policy(self, policy_user_name: str, dry_run: bool) -> None:
        if not dry_run:
            self.iam_client.detach_user_policy(
                UserName=policy_user_name,
                PolicyArn=self.policy_arn
            )

            self.logger.info(
                f"Detached policy {self.policy_name} from policy user {policy_user_name}")
        else:
            self.logger.info(
                f"Would detach policy {self.policy_name} from policy user {policy_user_name}")

    def __detach_role_policy(self, policy_role_name: str, dry_run: bool) -> None:
        if not dry_run:
            self.iam_client.detach_role_policy(
                RoleName=policy_role_name,
                PolicyArn=self.policy_arn
            )

            self.logger.info(
                f"Detached policy {self.policy_name} from role {policy_role_name}")
        else:
            self.logger.info(
                f"Would detach policy {self.policy_name} from role {policy_role_name}")

    def __delete_policy_version(self, policy_version_id: str, dry_run: bool) -> None:
        if not dry_run:
            self.iam_client.delete_policy_version(
                PolicyArn=self.policy_arn,
                VersionId=policy_version_id
            )
            self.logger.info(
                f"Deleting policy version {policy_version_id} from policy {self.policy_name}")
        else:
            self.logger.info(
                f"Would delete policy version {policy_version_id} from policy {self.policy_name}")


class IamPolicyResourceService(ResourceService):
    def __init__(self, session, recipe) -> None:
        super().__init__(session, recipe, "iam", "policy", True)

    def get_all(self, region):
        iam_client = self.session.create_client('iam', region)

        ignore_policy_names = []
        path_prefix = "/"
        for filter in self.recipe["filters"]:
            if filter["field"] == "PathPrefix":
                path_prefix = filter["value"]
            elif filter["field"] == "IgnorePolicy":
                ignore_policy_names.append(filter["value"])
            else:
                logging.error("Unknown filter type")

        resources = []
        complete = False
        marker = None

        while not complete:
            response = None
            if marker:
                response = iam_client.list_policies(
                    PathPrefix=path_prefix,
                    Scope='Local',
                    OnlyAttached=False,
                    Marker=marker,
                )
            else:
                response = iam_client.list_policies(
                    PathPrefix=path_prefix,
                    Scope='Local',
                    OnlyAttached=False,
                )

            if "Marker" in response:
                marker = response["Marker"]
            else:
                complete = True

            for policy in response["Policies"]:
                if policy["Path"] == path_prefix and policy["PolicyName"] not in ignore_policy_names:
                    resources.append(IamPolicy(self.session, region, policy))

        return resources
