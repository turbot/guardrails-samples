from .resource_service import ResourceService
from .resource import Resource
import logging


class IamRole(Resource):
    def __init__(self, session, region, role) -> None:
        self.role = role
        self.region = region
        self.logger = logging.getLogger(__name__)
        self.iam_client = session.create_client('iam', self.region)

        super().__init__(session)

    def details(self):
        return f'iam/role {self.role["RoleName"]}'

    def delete(self, dry_run):
        response = self.iam_client.list_attached_role_policies(
            RoleName=self.role["RoleName"],
        )
        for attached_policy in response["AttachedPolicies"]:
            if not dry_run:
                self.iam_client.detach_role_policy(
                    RoleName=self.role["RoleName"],
                    PolicyArn=attached_policy["PolicyArn"],
                )

                self.logger.info(
                    f"Detached role policy {attached_policy['PolicyName']} for role {self.role['RoleName']}")
            else:
                self.logger.info(
                    f"Would detach role policy {attached_policy['PolicyName']} for role {self.role['RoleName']}")

        response = self.iam_client.list_instance_profiles_for_role(
            RoleName=self.role["RoleName"],
        )
        for instance_profile in response["InstanceProfiles"]:
            if not dry_run:
                self.iam_client.remove_role_from_instance_profile(
                    RoleName=self.role["RoleName"],
                    InstanceProfileName=instance_profile["InstanceProfileName"],
                )

                self.logger.info(
                    f"Removed role {self.role['RoleName']} from instance profile {instance_profile['InstanceProfileName']}")
            else:
                self.logger.info(
                    f"Would remove role {self.role['RoleName']} from instance profile {instance_profile['InstanceProfileName']}")

        response = self.iam_client.list_role_policies(
            RoleName=self.role["RoleName"],
        )
        for policy_name in response["PolicyNames"]:
            if not dry_run:
                self.iam_client.delete_role_policy(
                    RoleName=self.role["RoleName"],
                    PolicyName=policy_name,
                )

                self.logger.info(
                    f"Deleted role policy {policy_name} for role {self.role['RoleName']}")
            else:
                self.logger.info(
                    f"Would delete role policy {policy_name} for role {self.role['RoleName']}")

        if not dry_run:
            self.iam_client.delete_role(
                RoleName=self.role["RoleName"]
            )
            self.logger.info(f"Deleted role {self.role['RoleName']}")
        else:
            self.logger.info(f"Would delete role {self.role['RoleName']}")


class IamRoleResourceService(ResourceService):
    def __init__(self, session, recipe) -> None:
        super().__init__(session, recipe, "iam", "role",  True)

    def get_all(self, region):
        iam_client = self.session.create_client('iam', region)

        resources = []
        for filter in self.recipe["filters"]:
            if filter["field"] == "PathPrefix":
                path_prefix = filter["value"]

                response = iam_client.list_roles(
                    PathPrefix=path_prefix
                )

                for role in response["Roles"]:
                    if role["Path"] == path_prefix:
                        resources.append(IamRole(self.session, region, role))

        return resources
