class AccountRecordCollection:
    def __init__(self) -> None:
        self.accounts = {}
        self.record_count = 0
        pass

    def __iter__(self):
        self.index = 0
        self.account_keys = list(self.accounts.keys())
        self.account_keys_len = len(self.account_keys)
        return self

    def __next__(self):
        index = self.index
        self.index += 1

        if self.index > self.account_keys_len:
            raise StopIteration

        account_id = self.account_keys[index]
        return account_id

    def add_record(self, account_id, finding_id, record):
        if not account_id:
            raise ValueError("Parameter `account_id` for method `AccountRecordCollection.add_record` is missing")

        if not finding_id:
            raise ValueError("Parameter `finding_id` for method `AccountRecordCollection.add_record` is missing")

        if not record:
            raise ValueError("Parameter `record` for method `AccountRecordCollection.add_record` is missing")

        if account_id in self.accounts:
            if finding_id not in self.accounts[account_id]:
                self.record_count += 1

            self.accounts[account_id][finding_id] = record
        else:
            self.record_count += 1
            self.accounts[account_id] = {finding_id: record}

    def get_account_record(self, account_id, finding_id):
        if account_id in self.accounts and finding_id in self.accounts[account_id]:
            return self.accounts[account_id][finding_id]

        return None

    def get_record_count(self):
        return self.record_count

    def get_accounts_list(self):
        return list(self.accounts.keys())

    def get_records(self, account_id):
        if account_id in self.accounts:
            return self.accounts[account_id]

        return []
