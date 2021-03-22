class Record:
    def __init__(self, id, control_type, account_id, updated_timestamp, partition, region_name, resource_id, title, description, akas, control_state, tags) -> None:
        self.id = id
        self.control_type = control_type
        self.account_id = account_id
        self.updated_timestamp = updated_timestamp
        self.partition = partition
        self.region_name = region_name
        self.resource_id = resource_id
        self.title = title
        self.description = description
        self.akas = akas
        self.control_state = control_state
        self.tags = tags
