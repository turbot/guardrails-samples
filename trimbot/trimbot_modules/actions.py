import logging


class CheckAction:
    def __init__(self) -> None:
        self.logger = logging.getLogger(__name__)
        super().__init__()

    def run_action(self, service, region, actions):
        resources = service.get_all(region)
        for resource in resources:
            try:
                self.logger.debug(f"Running actions against resource {resource.details()}")

                for action in actions:
                    if action == "check":
                        self.logger.debug(f"Running check action for resource {resource.details()}")
                        resource.check()

                self.logger.debug(f'Completed actions for resource {resource.details()}')
            except Exception as e:
                self.logger.error(f'Action for resource {resource.details()} failed')
                self.logger.error(e)

    def should_process(self, actions):
        return "check" in actions


class NoCheckAction:
    def __init__(self, dry_run) -> None:
        self.dry_run = dry_run
        self.logger = logging.getLogger(__name__)
        super().__init__()

    def run_action(self, service, region, actions):
        resources = service.get_all(region)
        for resource in resources:
            try:
                self.logger.debug(f"Running actions against resource {resource.details()}")

                for action in actions:
                    if action == "delete":
                        self.logger.debug(f"Running delete action for resource {resource.details()}")
                        resource.delete(self.dry_run)
                    elif action == "disable":
                        self.logger.debug(f"Running disable action for resource {resource.details()}")
                        resource.disable(self.dry_run)
                    elif action == "rename":
                        self.logger.debug(f"Running rename action for resource {resource.details()}")
                        resource.rename(self.dry_run)

                self.logger.debug(f'Completed actions for resource {resource.details()}')
            except Exception as e:
                self.logger.error(f'Action for resource {resource.details()} failed')
                self.logger.error(e)

    def should_process(self, actions):
        return False if "check" in actions and len(actions) == 1 else True
