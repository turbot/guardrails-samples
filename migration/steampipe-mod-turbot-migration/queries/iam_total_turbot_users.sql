select account_id                                                    as resource,
       'info'                                                        as status,
       account_id || ' has ' || count(*) || ' managed Turbot users.' as reason,
       _ctx ->> 'connection_name'                                    as connection_name,
       account_id
from aws_iam_user
where path like '%/turbot/%'
group by account_id, connection_name;
