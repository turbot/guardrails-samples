select account_id                                                    as resource,
       'info'                                                        as status,
       account_id || ' has ' || count(*) || ' managed Turbot groups.' as reason,
       _ctx ->> 'connection_name'                                    as connection_name,
       account_id
from test_sandbox.aws_iam_group
where path like '%/turbot/%'
group by account_id, connection_name;