# NOTE: Should really be using resource service not a raw session
class Resource:
    def __init__(self, session) -> None:
        self.session = session
        super().__init__()

    def delete(self, dry_run):
        pass

    def disable(self, dry_run):
        pass

    def rename(self, dry_run):
        pass

    def check(self):
        pass
