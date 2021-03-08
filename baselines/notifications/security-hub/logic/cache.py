import os
from pymemcache.client.base import Client


class Cache:
    def __init__(self, client) -> None:
        if client:
            self.__get_findings_strategy = self.__get_findings_cache_strategy
            self.__get_strategy = self.__get_cache_strategy
            self.__set_strategy = self.__set_cache_strategy
        else:
            self.__get_findings_strategy = self.__get_findings_no_cache_strategy
            self.__get_strategy = self.__get_no_cache_strategy
            self.__set_strategy = self.__set_no_cache_strategy

        self.client = client

    @staticmethod
    def create():
        endpoint = os.getenv("MEMCACHED_CONFIGURATION_ENDPOINT")
        client = None
        if endpoint:
            client = Client(endpoint)

        return Cache(client)

    def get(self, key):
        return self.__get_strategy(key)

    def set(self, key, value):
        return self.__set_strategy(key, value)

    def get_findings(self, ids):
        return self.__get_findings_strategy(ids)

    def __get_no_cache_strategy(self, key):
        return None

    def __set_no_cache_strategy(self, key, value):
        return None

    def __get_cache_strategy(self, key):
        return self.client.get(key)

    def __set_cache_strategy(self, key, value):
        return self.client.set(key, value)

    def __get_findings_cache_strategy(self, ids):
        cache_found_id_map = {}
        cache_missed_id_list = []

        for id in ids:
            last_updated_ts = self.client.get(id)
            if last_updated_ts == None:
                cache_missed_id_list.append(id)
            else:
                last_updated_ts = last_updated_ts.decode("UTF-8")
                print(f"Cache hit - Adding id cache found id map - {id} - {last_updated_ts}")
                cache_found_id_map[id] = last_updated_ts

        return cache_found_id_map, cache_missed_id_list

    def __get_findings_no_cache_strategy(self, ids):
        return {}, ids
